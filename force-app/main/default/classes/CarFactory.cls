public class CarFactory {
  private static final List<String> CAR_MODELS = new List<String>{
    'BMW',
    'Mercedes-Benz',
    'Audi',
    'Toyota',
    'Honda',
    'Tesla Model Plaid',
    'Rivian R1T'
  };

  public void addCars() {
    List<Vehicle__c> vehicles = new List<Vehicle__c>();

    for (String name : CAR_MODELS) {
      Vehicle__c vehicle = new Vehicle__c();
      vehicle.Name = name;
      vehicle.Cost__c = Integer.valueOf(Math.random() * 10000);
      vehicles.add(vehicle);
    }

    insert vehicles;
  }
}
