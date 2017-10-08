
import java.nio.charset.Charset;
import java.security.InvalidKeyException;


void setup() {
  
  size(1000, 100);
  background(150);
  textSize(28); 
  fill(50, 102, 153);
   
  StringBuilder result = new StringBuilder();
  
  int[] keyIntegers = new KeyGenerator().core("Key Generator String");

  long [] key = new long[4];

  key[0] = keyIntegers[0];
  key[1] = keyIntegers[1];
  key[2] = keyIntegers[2];
  key[3] = keyIntegers[3];
  
  //            012345670123456701234567012345670123456701234567    ---- Multiple of 8 !!!
  String str = "Hello from the world of hell: TEA and Java!!!";
  
  if(str.length() % 8 != 0)  // is the string length a multiple of 8?
  {
      int nSpaces = 8 - str.length() % 8;  // if not ... pad with white spaces
      
      for(int i=0; i<nSpaces; i++)
      {
          str += " ";
      }
      System.out.println(str.length() + ": " + str);
  }

  byte[] b = str.getBytes(Charset.forName("UTF-8"));

  XTEAEncryptionEngine xtea = new XTEAEncryptionEngine();
  
  try {
      xtea.init(key);
  }
  catch(InvalidKeyException e) {
      System.out.println(e);
  }

  try {
    for(int ii=0; ii<str.length(); ii+=8)
    {
      byte [] encrypted; 
      encrypted = xtea.encrypt(b, ii);

      byte [] decrypted;
      decrypted = xtea.decrypt(encrypted);

      result.append(new String(decrypted, "UTF-8"));
    }
    text(result.toString().trim(), 150, 60);  // use trim() to remove 'padding' whitespaces
    System.out.println(result);
  }
  catch(IOException e) 
  {
      System.out.println(e);
  }
}

void loop() {
}