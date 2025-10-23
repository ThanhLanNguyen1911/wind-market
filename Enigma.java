import java.security.MessageDigest;

public class Enigma{

private String char_array="qwetryiuopagsfdhjklzxvbcnm0123456789MNBVCZXLKJFHGDSAQRETWYUOPI";
private String algorithm="SHA-1";

public void setAlgorithm(String value){
 algorithm=value;
}

public String getEncryption(String password){
    String outvalue = "";
    try{
    MessageDigest md = MessageDigest.getInstance(algorithm);
    md.update(password.getBytes("ISO-8859-1"));
    outvalue = new String(md.digest(),"ISO-8859-1");
    md.reset();
    }catch(Exception e){}

    return outvalue;
}

public String genToken(int length){
//create token
int maxsize = char_array.length()-1;
String token="";
for(int i=0;i<length;++i){//n chars random token
   int random_index = (int)(Math.random()*maxsize);
   if(random_index > maxsize){
   random_index=0;
   }
   token+=char_array.charAt(random_index);
}
return token;
}

}
