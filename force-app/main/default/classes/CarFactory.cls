public class CarFactory {

    private static final List<String> CAR_MODELS = new List<String> {'BMW', 'Mercedes-Benz', 'Audi', 'Toyota', 'Honda','Tesla Model Plaid','Rivian R1T'};

	public void addCars() { 
        
        List<String> carModels = CAR_MODELS;

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