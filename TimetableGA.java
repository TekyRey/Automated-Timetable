package schedulingSystem;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;



public class TimetableGA {
	public static String url="jdbc:mysql://localhost/mmustable";
	public static String user="root";
	public static String password="";

    public static void main(String[] args) {
    	
    	
    	
    	
    	
    	
    	String query="SELECT * FROM Room";
    	//String query1="SELECT * FROM Module";
    	
    	
    	try(Connection con=DriverManager.getConnection(url,user,password);
    			Statement st=con.createStatement();
    			ResultSet rs=st.executeQuery(query)){

                 
             }
    	
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}
    
    			
    	
    	// Get a Timetable object with all the available information.
        Timetable timetable = initializeTimetable();
        
        // Initialize GA
        GeneticAlgorithm ga = new GeneticAlgorithm(100, 0.01, 0.9, 2, 5);
        
        // Initialize population
        Population population = ga.initPopulation(timetable);
        
        // Evaluate population
        ga.evalPopulation(population, timetable);
        
        // Keep track of current generation
        int generation = 1;
        
        // Srt evolution loop
        while (ga.isTerminationConditionMet(generation, 1000) == false
            && ga.isTerminationConditionMet(population) == false) {
            // Print fitness
            System.out.println("G" + generation + " Best fitness: " + population.getFittest(0).getFitness());

            // Apply crossover
            population = ga.crossoverPopulation(population);

            // Apply mutation
            population = ga.mutatePopulation(population, timetable);

            // Evaluate population
            ga.evalPopulation(population, timetable);

            // Increment the current generation
            generation++;
        }

        // Print fitness
        timetable.createClasses(population.getFittest(0));
        System.out.println();
        System.out.println("Solution found in " + generation + " generations");
        System.out.println("Final solution fitness: " + population.getFittest(0).getFitness());
        System.out.println("Clashes: " + timetable.calcClashes());

        // Print classes
        System.out.println();
        Class classes[] = timetable.getClasses();
        int classIndex = 1;
        for (Class bestClass : classes) {
          System.out.println("Class " + classIndex + ":");
          System.out.println("Module: " + 
                    timetable.getModule(bestClass.getModuleId()).getModuleName());
            System.out.println("Group: " + 
                    timetable.getGroup(bestClass.getGroupId()).getGroupId());
            System.out.println("Room: " + 
                    timetable.getRoom(bestClass.getRoomId()).getRoomNumber());
            System.out.println("Professor: " + 
                    timetable.getProfessor(bestClass.getProfessorId()).getProfessorName());
            System.out.println("Time: " + 
                    timetable.getTimeslot(bestClass.getTimeslotId()).getTimeslot());
            System.out.println("-----");
            classIndex++;
        
        }
    }

   
     //Creates a Timetable with all the necessary course information.
    
      private static Timetable initializeTimetable() {
		// Create timetable
		Timetable timetable = new Timetable();
		
		

		// Dynamic Set up rooms
		
		String query2="SELECT * FROM Room";
    	
    	try(Connection con2=DriverManager.getConnection(url,user,password);
    			Statement st=con2.createStatement();
    			ResultSet rs=st.executeQuery(query2)){
    		
    	    while (rs.next()) {

    	    	timetable.addRoom(rs.getInt(1),rs.getString(2),rs.getInt(3));
                 
    		 }
                 
             }
    	
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}

		
		// Set up timeslots
    	String queryTimeSlots="SELECT * FROM Timeslot";

    	try(Connection con2=DriverManager.getConnection(url,user,password);
    			Statement st=con2.createStatement();
    			ResultSet rs=st.executeQuery(queryTimeSlots)){
    		
    	    while (rs.next()) {

    	    	timetable.addTimeslot(rs.getInt(1),rs.getString(2));
                
    		 }
                 
             }
    	
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}



		// Set up professors
    	String queryProfessor="SELECT * FROM Professor";
    	
    	try(Connection con2=DriverManager.getConnection(url,user,password);
    			Statement st=con2.createStatement();
    			ResultSet rs=st.executeQuery(queryProfessor)){
    		
    	    while (rs.next()) {

    	    	timetable.addProfessor(rs.getInt(1),rs.getString(2));
                
    		 }
                 
             }
    	
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}
    	


//		 Set up modules and define the professors that teach them
    	String queryModule="SELECT DISTINCT moduleid,moduleCode,module FROM Module";
    	
    	try(Connection con2=DriverManager.getConnection(url,user,password);
    			Statement st=con2.createStatement();
    			ResultSet rs=st.executeQuery(queryModule)){
    		
    	    while (rs.next()) {
    	    	//create a subquery to fetch professor ids
    	    	int moduleId = rs.getInt(1);
    	    
    	    	Statement st2=con2.createStatement();
    	    	String subquery1 = "SELECT professorIds FROM Module WHERE moduleId=" +moduleId;
    	    	
    	    	ResultSet rs2 = st2.executeQuery(subquery1);
    	    	ArrayList<Integer> profs = new ArrayList<Integer>();

        	    while (rs2.next()) {
        	    	profs.add(rs2.getInt(1));
        	    	
        		 }
        	    
        	    int[] profarray = profs.stream().mapToInt((Integer i) ->  i.intValue()).toArray();

    	    	timetable.addModule(rs.getInt(1),rs.getString(2),rs.getString(3),profarray);           
    		 }
    	}
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}
    	
    	
    	
		//Set up student groups and the modules they take.
    	
String queryCourse="SELECT DISTINCT courseId,groupSize FROM Course";
    	
    	try(Connection con2=DriverManager.getConnection(url,user,password);
    			Statement st=con2.createStatement();
    			ResultSet rs=st.executeQuery(queryCourse)){
    		
    	    while (rs.next()) {
    	    	//create a subquery to fetch professor ids
    	    	int courseId = rs.getInt(1);
    	    
    	    	Statement st3=con2.createStatement();
    	    	String subquery2 = "SELECT moduleIds FROM Course WHERE courseId=" +courseId;
    	    	
    	    	ResultSet rs3 = st3.executeQuery(subquery2);
    	    	ArrayList<Integer> mods = new ArrayList<Integer>();

        	    while (rs3.next()) {
        	    	mods.add(rs3.getInt(1));
        	    	
        		 }
        	    
        	    int[] modsarray = mods.stream().mapToInt((Integer i) ->  i.intValue()).toArray();

    	    	timetable.addGroup(rs.getInt(1),rs.getInt(2),modsarray);           
    		 }
    	}
    	catch (SQLException ex) {
    		 Logger lgr = Logger.getLogger(TimetableGA.class.getName());
             lgr.log(Level.SEVERE, ex.getMessage(), ex);
    	}
	
		return timetable;
}
}
