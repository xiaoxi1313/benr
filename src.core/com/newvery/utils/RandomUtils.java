package com.newvery.utils;

import java.util.Random;

public class RandomUtils {
	private static String randString = "0123456789";
	/*
     * 获取随机的字符
     */
    public static String getRandomString(int num){
        return String.valueOf(randString.charAt(num));
    }
	public static String generateRandom(int length){
		 Random random = new Random();
		
		StringBuilder b = new StringBuilder();
		for(int i =0;i<length;i++){
			b.append(getRandomString(random.nextInt(randString.length())));
		}
		return b.toString();
	}
	public static void main(String[] args){
		System.out.println(generateRandom(5));
	}
}
