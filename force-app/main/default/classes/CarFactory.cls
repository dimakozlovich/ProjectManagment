public class CarFactory {

	public void addCars() { 
        
        List<String> carModels = new List<String>{'BMW', 'Mercedes-Benz', 'Audi', 'Toyota', 'Honda','Tesla Model Plaid','Rivian R1T'};

        List<Vehicle__c> vehicles = new List<Vehicle__c>();

        for (String name : carModels) {
            Vehicle__c vehicle = new Vehicle__c();
            vehicle.Name = name;
            vehicle.Cost__c = Math.random();
            vehicles.add(vehicle);
        }
       
		insert vehicles;
   }

}