package com.example.demo.util;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public class Util {
	public static String getDate() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD hh:mm:ss");

		return sdf.format(date);
	}

	public static Map<String, Object> mapOf(Object... args) {
		Map<String, Object> map = new LinkedHashMap<>();
		int length = args.length;

		if (length % 2 != 0) {
			throw new IllegalArgumentException("인자의 개수를 짝수로 입력해주세요.");
		}

		for (int i = 0; i < length; i += 2) {
			map.put(String.valueOf(args[i]), args[i + 1]);
		}

		return map;
	}

	public static int getAsInt(Object object, int defaultValue) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Double) {
			return (int) Math.floor((double) object);
		} else if (object instanceof Float) {
			return (int) Math.floor((Float) object);
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return defaultValue;
	}

	public static String msgAndBack(String msg) {
		StringBuilder sb = new StringBuilder();

		sb.append("<script>");
		sb.append("alert('" + msg + "');");
		sb.append("history.back();");
		sb.append("</script>");

		return sb.toString();
	}

	public static String msgAndReplace(String msg, String url) {
		StringBuilder sb = new StringBuilder();

		sb.append("<script>");
		sb.append("alert('" + msg + "');");
		sb.append("location.replace('" + url + "');");
		sb.append("</script>");

		return sb.toString();
	}
	
	public static boolean allNumberString(String str) {
		for(int i = 0; i<str.length(); i++)
			if(Character.isDigit(str.charAt(i)) == false)
				return false;
		
		return true;
	}

	public static boolean startsWithNumber(String str) {
		
		return Character.isDigit(str.charAt(0));
	}

	public static boolean isStandardLoginIdCheck(String str) {
		
		// 조건 : 5자 이상 15자 이하 / 숫자시작 금지 / _, 알파벳, 숫자
		return Pattern.matches("^[a-zA-Z]{1}[a-zA-Z0-9_]{4,14}$", str);
	}

	public static boolean isEmpty(Object data) {
		if (data == null) {
			return true;
		}

		if (data instanceof String) {
			String strData = (String) data;

			return strData.trim().length() == 0;
		} else if (data instanceof Integer) {
			Integer integerData = (Integer) data;

			return integerData != 0;
		} else if (data instanceof List) {
			List listData = (List) data;

			return listData.isEmpty();
		} else if (data instanceof Map) {
			Map mapData = (Map) data;

			return mapData.isEmpty();
		}

		return true;
	}

	public static <T> T ifEmpty(T data, T defaultValue) {
		if (isEmpty(data)) {
			return defaultValue;
		}

		return data;
	}

}
