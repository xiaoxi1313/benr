package com.newvery.utils.secure;

import java.util.Random;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import com.newvery.utils.Base64;


public class DesUtil {
	private static final int IV_LEN = 8;
	
    private static final String ENC_FLAG = "~|!&";
    
	public static byte[] enc3DES(byte[] inputData, byte[] key, boolean useIv) throws Exception {
		Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
		
		cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(key, "DESede"));
		
		byte[] input;
		if (useIv) {
			input = new byte[inputData.length + IV_LEN];
			new Random().nextBytes(input);
			System.arraycopy(inputData, 0, input, IV_LEN, inputData.length);
		} else {
			input = inputData;
		}
		
		return cipher.doFinal(input);
	}
	
	public static byte[] dec3DES(byte[] input, byte[] key, boolean useIv) throws Exception {
		Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
		
		cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(key, "DESede"));

		byte[] cipherText = cipher.doFinal(input);
		
		if (useIv) {
			// 切除头部随机数
			byte[] ret = new byte[cipherText.length - IV_LEN];
			System.arraycopy(cipherText, IV_LEN, ret, 0, ret.length);
			return ret;
		} else
			return cipherText;
	}
	
	public static String enc3DES(String input, byte[] key) throws Exception {
		// 增加加密标记，防止解密时误判
		byte[] encData = enc3DES(input.getBytes("UTF-8"), key, true);
		return new String(Base64.encode(encData));
	}
	
	public static String dec3DES(String input, byte[] key) throws Exception {
		byte[] decData = dec3DES(Base64.decode(input), key, true);
		
		return new String(decData); 
	}
    
    public static String tryDec3DES(String input, byte[] key) throws Exception {
        byte[] decData;
        try {
            decData = dec3DES(Base64.decode(input), key, true);
        } catch (Exception e) {
            // 不是加密数据
            return input;
        }
        
        String txt = new String(decData); 
        if (txt.startsWith(ENC_FLAG)) {
            return txt.substring(ENC_FLAG.length(), txt.length());
        } else
            return input;
    }
    
    
    
    public static byte[] decDES(byte[] cipher, byte[] key) throws Exception
    {
        //与客户端算法统一
        SecretKeySpec deskey = new SecretKeySpec(key, "DES");
        Cipher c = Cipher.getInstance("DES/ECB/PKCS5Padding");
        
        c.init(Cipher.DECRYPT_MODE, deskey);
        return c.doFinal(cipher);
    }
    
    public static byte[] encDES(byte[] plainText, byte[] key) throws Exception
    {
        //与客户端算法统一
        SecretKeySpec deskey = new SecretKeySpec(key, "DES");
        Cipher c = Cipher.getInstance("DES/ECB/PKCS5Padding");
        
        c.init(Cipher.ENCRYPT_MODE, deskey);
        return c.doFinal(plainText);
    }

}
