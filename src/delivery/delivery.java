package delivery;
import java.sql.*;
import java.time.*;
import javax.swing.*;

public class delivery {
	public static void query1 (Connection con) { 
		try {
			String cliente = JOptionPane.showInputDialog("Inserire identificativo cliente");
			String query1 = ("select cliente from ordine where cliente="+cliente);
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(query1);
			if(!result.isBeforeFirst()){
				JOptionPane.showMessageDialog(null ,"Cliente non registrato, devi prima registrarti per utilizzare il servizio");
				return;
			}
			else{
				String ristorante = JOptionPane.showInputDialog("Inserire ristorante in cui effettuare l'ordine");
				String sql2 = ("SELECT telefono FROM ristorante WHERE telefono="+ristorante);
				ResultSet result2 = stmt.executeQuery(sql2);
				if(!result2.isBeforeFirst()){
					JOptionPane.showMessageDialog(null ,"Ristorante inserito non valido");
					return;
				}
				else{
					String desc = JOptionPane.showInputDialog("Inserire descrizione per l'ordine");
					LocalDate now= LocalDate.now();
					String insert1 = "INSERT INTO Ordine(cliente,ristorante,data,descrizione)VALUES('"+cliente+"','"+ristorante+"','"+now+"','"+desc+"');";
					if(stmt.executeUpdate(insert1)!=1){
						JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
						return;
					}
					String tipo = JOptionPane.showInputDialog("Inserire tipo dell'ordine");
					int nGior=0;
					do{
						ResultSet tipoOrdine= stmt.executeQuery("select max(giornaliero) from ordine where ristorante='"+ristorante+"' and data='"+now+"'");
						if(tipoOrdine.next()) {
							nGior=tipoOrdine.getInt(1);
						}
						else {
							JOptionPane.showMessageDialog(null ,"Errore query 1");
							return;
						}
						String insert2 = "INSERT INTO Tipo_Ordine(ristorante, data, giornaliero, tipo)VALUES('"+ristorante+"','"+now+"','"+nGior+"','"+tipo+"');";
						if(stmt.executeUpdate(insert2)!=1){
							JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
							return;
						}
						tipo = JOptionPane.showInputDialog("Inserire tipo dell'ordine - 0 per fine");
					}while(!tipo.contains("0"));
				}
			}
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query 1");
			e.printStackTrace();
		}
	}
	
	public static void query2(Connection con) { 
		try {
			String ristorante = JOptionPane.showInputDialog("Inserire identificativo ordine: Ristorante");
			LocalDate data = LocalDate.parse(JOptionPane.showInputDialog("Inserire identificativo ordine: data(yyyy-mm-dd)"));
			int giornaliero = Integer.parseInt(JOptionPane.showInputDialog("Inserire identificativo ordine: Giornaliero"));
			String sql1 = ("SELECT ristorante,data,giornaliero FROM ORDINE WHERE ristorante='"+ristorante+"'and data='"+data+"' and stato='ordinato' and giornaliero="+giornaliero);
			Statement stmt = con.createStatement();
			ResultSet result1 = stmt.executeQuery(sql1);
			if(!result1.isBeforeFirst()){
				JOptionPane.showMessageDialog(null ,"Ordine non presente oppure è stato già consegnato");
				return;
			}
			else{
				String rider = JOptionPane.showInputDialog("Inserire identificativo Rider/Dipendente: ");
				String sql2 = ("SELECT telefono FROM rider_esterno WHERE telefono="+rider);
				ResultSet result2 = stmt.executeQuery(sql2);
				Statement stmt2= con.createStatement();
				String sql3 = ("SELECT telefono FROM dipendente WHERE telefono="+rider);
				ResultSet result3 = stmt2.executeQuery(sql3);
				if(!result2.next() && !result3.next()){
					JOptionPane.showMessageDialog(null ,"Rider inserito non valido");
					return;
				}
				else {
					String nomeRicevente = JOptionPane.showInputDialog("Inserisci il nome del ricevente");
					String cognomeRicevente = JOptionPane.showInputDialog("Inserisci il cognnome del ricevente");
					String telefonoRicevente = JOptionPane.showInputDialog("Inserisci il telefono del ricevente");
					LocalDateTime now= LocalDateTime.now();
					if(result2.next()) {
						String insert1 = "INSERT INTO consegna_rider_esterno(Giornaliero, Data, Ristorante, Rider_Esterno, Nome_Ricevente, Cognome_Ricevente, Telefono_Ricevente, Orario_Effettivo)"
								+ "VALUES('"+giornaliero+"','"+data+"','"+ristorante+"','"+rider+"','"+nomeRicevente+"','"+cognomeRicevente+"','"+telefonoRicevente+"','"+now+"')";
						if(stmt.executeUpdate(insert1)!=1){
							JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
							return;
						}
					}
					else {
						String insert1 = "INSERT INTO consegna_rider_esterno(Giornaliero, Data, Ristorante, Rider_Esterno, Nome_Ricevente, Cognome_Ricevente, Telefono_Ricevente, Orario_Effettivo)"
								+ "VALUES('"+giornaliero+"','"+data+"','"+ristorante+"','"+rider+"','"+nomeRicevente+"','"+cognomeRicevente+"','"+telefonoRicevente+"','"+now+"')";
						if(stmt.executeUpdate(insert1)!=1){
							JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
							return;
						}
					}
				}
			}
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query 2");
			e.printStackTrace();
		}
	}
	
	public static void query3(Connection con) { 
        try {
            String ristorante = JOptionPane.showInputDialog("Inserire ristorante");
            Statement stmt = con.createStatement();
            ResultSet result = stmt.executeQuery("SELECT * FROM ristorante WHERE telefono='"+ristorante+"'");
            if(!result.next()) {
	        	JOptionPane.showMessageDialog(null ,"Il ristorante non è presente");
	        	return;
	        }
            Statement stmt2 = con.createStatement();
            ResultSet result1 = stmt2.executeQuery("SELECT count(*) as NumeroOrdiniCoda FROM ordine WHERE stato='ordinato' AND ristorante='"+ristorante+"'");
            
            Statement stmt3 = con.createStatement();
            ResultSet result2 = stmt3.executeQuery("SELECT max_prenotazioni FROM Ristorante WHERE telefono='"+ristorante+"'");
            if(!result1.next() || !result2.next()) {
            	JOptionPane.showMessageDialog(null ,"Errore");
	        	return;
            }
            if(result1.getInt(1)==result2.getInt(1))
            	JOptionPane.showMessageDialog(null , "Non è possibile effettuare Ordini presso questo ristorante. Coda ordinazione piena.");
            else
            	JOptionPane.showMessageDialog(null , "É possibile effettuare Ordini presso questo ristorante.");
       	}
        catch(Exception e) {
            JOptionPane.showMessageDialog(null ,"Errore: query3");
            e.printStackTrace();
        }
    }
	
	public static void query4(Connection con) { 
		 try {
	            Statement stmt = con.createStatement();
	            ResultSet result = stmt.executeQuery("select r.telefono, r.nome, concat(r.via,\" / \",r.cap,\" / \",r.civico) as info_ristorante , r.max_prenotazioni, o.stato , count(r.telefono) as ordini_per_ristorante\r\n"
	            		+ "from ristorante r join ordine o on r.telefono = o.ristorante\r\n"
	            		+ "group by r.telefono\r\n"
	            		+ "having ordini_per_ristorante < r.max_prenotazioni");
	            String s= "Telefono  Nome  Info_ristorante  Max prenotazioni  Stato  Ordini per ristorante\n";
	            while(result.next()) {
	            	s+=result.getString("telefono")+" "+result.getString("nome")+" "+result.getString("info_ristorante")+" "+result.getString("max_prenotazioni")+" "+result.getString("stato")+" "+result.getString("ordini_per_ristorante")+"\n";
	            }
	            JOptionPane.showMessageDialog(null ,new JTextArea(s));
		 }
		 catch(Exception e) {
	            JOptionPane.showMessageDialog(null ,"Errore: query4");
	            e.printStackTrace();
	     }
	}
	
	public static void query5(Connection con) { 
        try{
        	String num_cliente = JOptionPane.showInputDialog("Inserisci il tuo numero di telefono");
            String num_rider = JOptionPane.showInputDialog("Inserisci il numero di telefono del rider");
            double score= Double.parseDouble(JOptionPane.showInputDialog("Inserisci lo score da assegnare al rider"));
        	LocalDateTime now = LocalDateTime.now();
	        Statement stmt = con.createStatement();
	        ResultSet result1= stmt.executeQuery("select telefono from cliente where telefono=" + num_cliente);
	        Statement stmt2 = con.createStatement();
	        ResultSet result2= stmt2.executeQuery("select telefono from rider_esterno where telefono=" + num_rider);
	        Statement stmt3 = con.createStatement();
	        ResultSet result3= stmt3.executeQuery("select * from consegna_rider_esterno natural join Ordine where rider_esterno='"+num_rider+"' and cliente='"+ num_cliente+"'");
	        if(!result1.next() || !result2.next() || !result3.next()) {
	        	JOptionPane.showMessageDialog(null ,"I dati inseriti sono errati");
	        	return;
	        }
	        else { 
	        	Statement stmt4 = con.createStatement();
	        	String sql="insert into Valutazione(Cliente, Rider_Esterno, Score, Data_Valutazione)values('" + num_cliente + "','" + num_rider + "','" + score + "','" + now + "')";
	        	if(stmt4.executeUpdate(sql)!=1){
					JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
					return;
				}
	        }
	    }
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore: query5");
			e.printStackTrace();
		}
	}
	
	public static void query6(Connection con) { 
		try {
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("select c.nome, count(*) as NumeroOrdini from ordine o join cliente c on o.cliente = c.telefono group by c.telefono order by c.telefono;");
			String s="Nome\tNumero Ordini\n";
			while(result.next()) {
				s+=result.getString(1) + "\t" + result.getString(2) + "\n";
			}
			JOptionPane.showMessageDialog(null , new JTextArea(s));
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore: query6");
			e.printStackTrace();
		}
	}
	
	public static void query7 (Connection con) { 
        try{
        	String codice = JOptionPane.showInputDialog("Inserire codice per identificare il servizio di delivery");
        	String updatesocieta = JOptionPane.showInputDialog("Inserire Società di delivery a cui affidare il servizio di delivery ");
            String sql1 = ("SELECT * FROM servizio_delivery_esterno WHERE ID_Servizio_Delivery_Esterno = "+codice);
            Statement stmt = con.createStatement();
            ResultSet result1 = stmt.executeQuery(sql1);
            String sql2 = ("SELECT * FROM societa_delivery WHERE P_IVA ='"+updatesocieta+"'");
            Statement stmt2 = con.createStatement();
            ResultSet result2 = stmt2.executeQuery(sql2);
            if(!result1.next() || !result2.next()){
                JOptionPane.showMessageDialog(null ,"Dati inseriti errati");
                return;
            }
            else{
            	String sql3 = ("UPDATE servizio_delivery_esterno SET societa='"+updatesocieta+"' WHERE id_servizio_delivery_esterno = "+codice);
                if(stmt.executeUpdate(sql3)!=1){
                    JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
                    return;
                }
                JOptionPane.showMessageDialog(null ,"Affidamento eseguito con successo");
            }
        }
        catch(Exception e) {
            JOptionPane.showMessageDialog(null ,"Errore query 7");
            e.printStackTrace();
        }
	}
	
	public static void query8 (Connection con) {
		try {
			String telefono = JOptionPane.showInputDialog("Inserire numero di telefono dipendente");
			String sql = ("SELECT telefono FROM Dipendente WHERE telefono='"+telefono+"'");
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery(sql);
			if(!result.isBeforeFirst()){
				
				String nome = JOptionPane.showInputDialog("Inserire nome del dipendente");
				String cognome = JOptionPane.showInputDialog("Inserire cognome del dipendente");
				String cv = JOptionPane.showInputDialog("Inserire ShortCurriculum del dipendente");
				String tipoc = JOptionPane.showInputDialog("Inserire tipo di contratto del dipendente");
				int anni = Integer.parseInt(JOptionPane.showInputDialog("Inserire anni esperienza"));
				int delivery = Integer.parseInt(JOptionPane.showInputDialog("Inserire identificativo delivery interno"));
				
				String sql2= ("SELECT id_servizio_delivery_interno FROM servizio_delivery_interno WHERE id_servizio_delivery_interno="+delivery);
				ResultSet result2 = stmt.executeQuery(sql2);
				if(!result2.isBeforeFirst()){
					JOptionPane.showMessageDialog(null ,"Servizio di delivery interno non esistente");
					return;
				}
				else{
					String auto = JOptionPane.showInputDialog("Inserire identificativo autoveicolo");
					if(auto.isEmpty()) {
						LocalDate now= LocalDate.now();
						String query4 = ("INSERT INTO Dipendente(telefono,nome,cognome,short_curriculum,data_presa_servizio,tipo_contratto,anni_esperienza,servizio_delivery_interno)"
								+ "VALUES ('"+telefono+"','"+nome+"','"+cognome+"','"+cv+"','"+now+"','"+tipoc+"',"+anni+","+delivery+")");
						if(stmt.executeUpdate(query4)!=1){
							JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
							return;
						}
						JOptionPane.showMessageDialog(null ,"Dipendente inserito correttamente");
					}
					else {
						String sql3 = ("SELECT targa FROM veicolo WHERE targa='"+auto+"'");
						ResultSet result3 = stmt.executeQuery(sql3);
						if(!result3.isBeforeFirst()){
							JOptionPane.showMessageDialog(null ,"Veicolo non esistente");
							return;
						}
						else{
								LocalDate now= LocalDate.now();
								String query4 = ("INSERT INTO Dipendente(telefono,nome,cognome,short_curriculum,data_presa_servizio,tipo_contratto,anni_esperienza,servizio_delivery_interno,veicolo)"
										+ "VALUES ('"+telefono+"','"+nome+"','"+cognome+"','"+cv+"','"+now+"','"+tipoc+"',"+anni+","+delivery+",'"+auto+"')");
								if(stmt.executeUpdate(query4)!=1){
									JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
									return;
								}
								JOptionPane.showMessageDialog(null ,"Dipendente inserito correttamente");
						}
					}
				}
			}
			else{
					JOptionPane.showMessageDialog(null ,"Dipendente già registrato");
					return;
			}
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query 8");
			e.printStackTrace();
		}
	}
	
	public static void query9(Connection con) { 
		try {
			String sql = ("select nome\r\n"
					+ "from Ristorante\r\n"
					+ "where Telefono= any (select distinct Ristorante from Servizio_Delivery_Interno) or \r\n"
					+ "Telefono= any (select distinct Ristorante from servizio_delivery_esterno where societa="
					+ "(select P_IVA from Societa_Delivery where Nome='Food Delivery'))");
	        Statement stmt = con.createStatement();
	        ResultSet result = stmt.executeQuery(sql);
	        String s="";
	        while(result.next()) {
	        	s+=result.getString(1) + "\n";
	        }
	        JOptionPane.showMessageDialog(null ,s);
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query9");
			e.printStackTrace();
		}
	}
	
	public static void query10 (Connection con) { 
	    try {
	            String sql = ("select *\r\n"
	            		+ "from ordine \r\n"
	            		+ "where (Giornaliero,Ristorante,Data) in\r\n"
	            		+ "									(select Giornaliero, Ristorante, Data \r\n"
	            		+ "									from Consegna_rider_esterno\r\n"
	            		+ "									where rider_esterno not in (select Rider_esterno from valutazione))");
	            Statement stmt = con.createStatement();
	            ResultSet result = stmt.executeQuery(sql);
	            if(!result.isBeforeFirst()){
	                JOptionPane.showMessageDialog(null ,"Nessun rider non valutato ha consegnato ordini");
	                return;
	            }
	            else{
	            	String s="Ristorante Data Cliente Tipo Stato #Giornaliero\n";
	            	while(result.next()) {
	                    s+=result.getString(1)+ " "+ result.getString(2)+ " "+ result.getString(3)+ " "+ result.getString(4)+ " "+ result.getString(6)+"\n";
	            	}
	            	JOptionPane.showMessageDialog(null , new JTextArea(s));
	            }
	    }
	    catch(Exception e) {
	        JOptionPane.showMessageDialog(null ,"Errore query 10");
	        e.printStackTrace();
	    }
	}
	
	public static void query11 (Connection con) { 
	    try {
	    	String ristorante = JOptionPane.showInputDialog("Inserire identificativo ordine: Ristorante");
			LocalDate data = LocalDate.parse(JOptionPane.showInputDialog("Inserire identificativo ordine: data(yyyy-mm-dd)"));
			int giornaliero = Integer.parseInt(JOptionPane.showInputDialog("Inserire identificativo ordine: Numero Giornaliero"));
			String sql = ("SELECT * FROM Ordine WHERE giornaliero="+giornaliero+" AND ristorante='"+ristorante+"' AND data='"+data+"' AND (stato!='consegnato')");
	        Statement stmt = con.createStatement();
	        ResultSet result = stmt.executeQuery(sql);
	        if(!result.isBeforeFirst()){
	            JOptionPane.showMessageDialog(null ,"Ordine non presente o già consegnato");
	            return;
	        }
	        else{
	        	String sql1="DELETE o FROM ordine o WHERE o.data='"+data+"' and o.giornaliero="+giornaliero+" and o.ristorante='"+ristorante+"'";
	        	if(stmt.executeUpdate(sql1)!=1){
		            JOptionPane.showMessageDialog(null ,"Errore inserimento dati");
		            return;
		        }
	            JOptionPane.showMessageDialog(null ,"Ordine cancellato con successo");
	        }
	    }
	    catch(Exception e) {
	        JOptionPane.showMessageDialog(null ,"Errore query 11");
	        e.printStackTrace();
	    }
	}
	
	public static void query12 (Connection con) { 
		try{
			String sql ="SELECT DISTINCT nome,cognome FROM rider_esterno WHERE telefono= ANY (SELECT rider_esterno FROM consegna_rider_esterno WHERE nome_ricevente='Giuseppe' AND cognome_ricevente='Verdi' AND DATEDIFF(data,sysdate())<=7 )"
					+ "UNION SELECT DISTINCT nome,cognome FROM Dipendente WHERE telefono= ANY (SELECT dipendente FROM consegna_dipendente WHERE nome_ricevente='Giuseppe' AND cognome_ricevente='Verdi' AND DATEDIFF(data,sysdate())<=7)";
            Statement stmt = con.createStatement();
            ResultSet result = stmt.executeQuery(sql);
            String s="Nome\tCognome\n";
            while(result.next()) {
            	s+=result.getString(1) + "\t" + result.getString(2) + "\n";
            }
            JOptionPane.showMessageDialog(null , new JTextArea(s));
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query12");
			e.printStackTrace();
		}
	}
		
	public static void query13(Connection con) {
		try {
			String sql1 ="select * from Ristorante";
            Statement stmt1 = con.createStatement();
            ResultSet result1 = stmt1.executeQuery(sql1);
            String s="Nome Max_Prenotazioni Telefono Indirizzo\n";
            while(result1.next()) {
            	s+="\n" + result1.getString(2) + "  " + result1.getString(6) + " " + result1.getString(1)+ " " + result1.getString(3) + "\\" + result1.getString(4) + "\\" +result1.getString(5) + "\n\n";
            	String sql2 ="select Ristorante,Data,Giornaliero,Cliente,Stato from Ordine where stato='ordinato' and ristorante=" + result1.getString(1);
            	Statement stmt2 = con.createStatement();
            	ResultSet result2 = stmt2.executeQuery(sql2);
                if(result2.isBeforeFirst()) {
	                s+="\tCoda degli ordini del Ristorante " + result1.getString(2) + "\n\tRistorante Data #Giornaliero Cliente Stato\n";
	                while(result2.next()) {
	                	s+="\t" + result2.getString(1) + " " + result2.getString(2) + " " + result2.getString(3) + " " + result2.getString(4) + " " + result2.getString(5) + "\n";
	                }
                }
            }
            JOptionPane.showMessageDialog(null , new JTextArea(s));
		}
		catch(Exception e) {
			JOptionPane.showMessageDialog(null ,"Errore query13");
			e.printStackTrace();
		}
	}
	
	public static void query14(Connection con) {
		try {
			String sql = ("SELECT * FROM rider_esterno");
            Statement stmt = con.createStatement();
            ResultSet result = stmt.executeQuery(sql);
    		String s="Telefono\tNome\tCognome\tDDN\tStato\tScore_Medio\tN_Società\tInizio_Impiego\tVeicolo\n";
            while(result.next()) {
    			s+=result.getString(1)+"\t"+result.getString(2)+"\t"+result.getString(3)+"\t"+result.getString(4)+"\t"+
            			result.getString(5)+"\t"+result.getString(6)+"\t"+result.getString(7)+"\t"+result.getString(8)+"\t"+
            			result.getString(9)+"\n";
            }
    		JOptionPane.showMessageDialog(null , new JTextArea(s));
		}
		catch(Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null ,"Errore query14");
		}
	}
		
	public static void query15(Connection con) {
	    try {
	        String sql = ("SELECT c.nome, c.cognome, c.telefono, v.score, v.data_valutazione FROM cliente c JOIN valutazione v ON c.telefono = v.cliente\r\n"
	        		+ "JOIN rider_esterno re ON v.rider_esterno = re.telefono WHERE v.score < re.score_medio AND DATEDIFF(v.data_valutazione,sysdate()) <=7");
	        Statement stmt = con.createStatement();
	        ResultSet result = stmt.executeQuery(sql);
	        String s="Nome\tCognome\tNumero Telefono \tScore Assegnato \tData di valutazione\n";
	        while(result.next()) {
	            s+=result.getString("nome")+"\t"+result.getString("cognome")+"\t"+result.getString("telefono")+"\t\t"+
	                    result.getString("score")+"\t\t"+result.getString("data_valutazione")+"\n";
	        }
	        JOptionPane.showMessageDialog(null , new JTextArea(s));
	    }
	    catch(Exception e) {
	        e.printStackTrace();
	        JOptionPane.showMessageDialog(null ,"Errore query15");
	    }
	}
	
	public static void main(String[] arg) throws SQLException{
		Connection con = null ;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/delivery?user=root&password=1234&serverTimezone=UTC");
		}
		catch(ClassNotFoundException e){
			 JOptionPane.showMessageDialog(null ,"Connessione fallita");
		}
		
		String menu="1. Registrazione di un ordine;\r\n"
				+ "2. Consegna di un ordine;\r\n"
				+ "3. Verifica della possibilità di effettuare un ordine ad un determinato ristorante;\r\n"
				+ "4. Visualizzazione dei ristoranti disponibili all’accettazione di un ordine;\r\n"
				+ "5. Valutazione di un rider;\r\n"
				+ "6. Visualizzazione per ogni cliente del numero di ordini effettuati;\r\n"
				+ "7. Abilitazione dell’affidamento ad una società di un servizio di delivery (già presente);\r\n"
				+ "8. Assunzione di un nuovo dipendente per la consegna degli ordini;\r\n"
				+ "9. Visualizzazione dei nomi dei ristoranti che impiegano dipendenti propri per la consegna o che si\r\n"
				+ "affidano ai servizi della società «Food Delivery»;\r\n"
				+ "10. Visualizzazione degli ordini consegnati da Raider ancora non valutati;\r\n"
				+ "11. Cancellazione di un ordine ancora non consegnato;\r\n"
				+ "12. Stampa di tutte le persone (nome, cognome) che abbiano consegnato ordini a «Giuseppe Verdi»\r\n"
				+ "nell’ultima settimana;\r\n"
				+ "13. Stampa di un report che mostri i dati dei ristoranti, incluso la coda di ordini attuale;\r\n"
				+ "14. Stampa settimanale di un report che mostri i dati dei rider, incluso lo score medio ottenuto\r\n"
				+ "nelle valutazioni da parte dei clienti;\r\n"
				+ "15. Stampa settimanale di tutti i clienti che nell’ultima settimana abbiano effettuato almeno una\r\n"
				+ "valutazione inferiore al corrispondente score medio di un raider;";
		
		int scelta = 0;
		do {
			try {
				scelta= Integer.parseInt(JOptionPane.showInputDialog(menu));
			}
			catch(Exception e) {}
			switch(scelta){
				case 1: 
						query1(con);
						break;
				case 2: 
						query2(con);
						break;
				case 3: 
						query3(con);
						break;
				case 4: 
						query4(con);
						break;
				case 5: 
						query5(con);
						break;
				case 6:
						query6(con);
						break;
				case 7: 
						query7(con);
						break;
				case 8:
						query8(con);
						break;
				case 9: 
						query9(con);
						break;
				case 10: 
						query10(con);
						break;
				case 11: 
						query11(con);
						break;
				case 12: 
						query12(con);
						break;
				case 13: 
						query13(con);
						break;
				case 14: 
						query14(con);
						break;
				case 15: 
						query15(con);
						break;
				default: break;
			}
		}while(scelta != 0);
		con.close();
	}	
}