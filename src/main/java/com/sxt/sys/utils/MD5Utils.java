package com.sxt.sys.utils;

import org.apache.shiro.crypto.hash.Md5Hash;

public class MD5Utils {
	/**
	 * 加密
	 * @param pwd
	 * @param salt
	 * @param hashIterations
	 */
	public static String md5(String pwd,String salt,Integer hashIterations) {
		String p4=new Md5Hash(pwd, salt,hashIterations ).toString();
		return p4;
	}

}
