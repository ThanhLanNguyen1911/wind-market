
public class Tinhthanh{
private int id;
private String name;//ten tinh
private int weight;//trong so van chuyen

public Tinhthanh(int ID,String NAME,int WEIGHT){
  id=ID;
  name=NAME;
  weight=WEIGHT;
}
//getter
public int GetId(){
 return this.id;
}

public String GetName(){
 return this.name;
}

public int GetWeight(){
 return this.weight;
}
}
