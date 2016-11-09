package com.newvery.validator;

/**
 * 身份证号码验证器
 *
 */
public class IdNumberVerifier {
	//身份证各位数字的权值 = 2(n-1)(mod 11) 
	static final int[] WEIGHT = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
	
	//校验码
	static final int[] VERIFY_CODES = {1,0,'X',9,8,7,6,5,4,3,2};
	
	static public boolean verify(String idNumber) {
		
		//将15位的身份证号码扩充到18位	
		if (idNumber.length() == 15) {
			idNumber = expand(idNumber);
		}

		if (idNumber.length() != 18) {
			return false;
		}

		String birthMonth = idNumber.substring(10,12);
		if (Integer.parseInt(birthMonth) > 12) {
			return false;
		}

		String birthDate = idNumber.substring(12,14);
		if (Integer.parseInt(birthDate) > 31) {
			return false;
		}

		String verifyCode = idNumber.substring(17, 18);
		if (verifyCode.equals(calcVerifyCode(idNumber))) {
			return true;
		}
	 
		return false;
	}
	
	static protected String calcVerifyCode(String idNumber) {

		int remaining = 0;
		int sum = 0;

		char[] charArray = idNumber.toCharArray();
			
		//加权求和
		for (int i = 0; i < WEIGHT.length; i++) {
			int value = (charArray[i] - '0');
			sum += (value * WEIGHT[i]);
		}

		remaining = sum % 11;
		
		return remaining == 2 ? "X" : String.valueOf(VERIFY_CODES[remaining]);
	}
	
	static protected String expand(String idNumber) {
		StringBuffer newIdNumber = new StringBuffer(idNumber.substring(0,6));

		newIdNumber.append("19");
		newIdNumber.append(idNumber.substring(6,15));
		newIdNumber.append(calcVerifyCode(newIdNumber.toString()));
		
		return newIdNumber.toString();
	} 
}
