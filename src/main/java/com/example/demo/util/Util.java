package com.example.demo.util;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	
	// 인터셉트 관련 유틸메소드
	public static Map<String, Object> getParamMap(HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();

		Enumeration<String> parameterNames = request.getParameterNames();

		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			Object paramValue = request.getParameter(paramName);

			param.put(paramName, paramValue);
		}

		return param;
	}

	public static String toJsonStr(Map<String, Object> param) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.writeValueAsString(param);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return "";
	}

	public static String getUrlEncoded(String str) {
		try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return str;
		}
	}

	public static <T> T ifNull(T data, T defaultValue) {
		return data != null ? data : defaultValue;
	}
	
	public static <T> T reqAttr(HttpServletRequest req, String attrName, T defaultValue) {
		return (T) ifNull(req.getAttribute(attrName), defaultValue);
	}

	public static String getFileExtTypeCodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
		case "gif":
		case "png":
			return "img";
		case "mp4":
		case "avi":
		case "mov":
			return "video";
		case "mp3":
			return "audio";
		}

		return "etc";
	}

	public static String getFileExtType2CodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
			return "jpg";
		case "gif":
			return ext;
		case "png":
			return ext;
		case "mp4":
			return ext;
		case "mov":
			return ext;
		case "avi":
			return ext;
		case "mp3":
			return ext;
		}

		return "etc";
	}

	public static String getFileExtFromFileName(String fileName) {
		int pos = fileName.lastIndexOf(".");
		String ext = fileName.substring(pos + 1);

		return ext;
	}

	public static String getNowYearMonthDateStr() {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy_MM");

		String dateStr = format1.format(System.currentTimeMillis());

		return dateStr;
	}

	public static List<Integer> getListDividedBy(String str, String dividedBy) {

		return Arrays.asList(str.split(dividedBy)).stream().map(s -> Integer.parseInt(s.trim()))
				.collect(Collectors.toList());
	}

	public static boolean deleteFile(String filePath) {
		java.io.File ioFile = new java.io.File(filePath);
		if (ioFile.exists())
			return ioFile.delete();

		return true;
	}
	
	public static String numberFormat(int num) {
		DecimalFormat df = new DecimalFormat("###,###,###");

		return df.format(num);
	}
	
	public static String dateFormat(String articleDate) {
		LocalDateTime nowDate = LocalDateTime.now();
		
		String[] dateSplit1 = articleDate.split(" ");
		String[] dateSplit2 = dateSplit1[0].split("-");
		String[] dateSplit3 = dateSplit1[1].split(":");
		
		int year = Util.getAsInt(dateSplit2[0], 0);
		int month = Util.getAsInt(dateSplit2[1], 0);
		int day = Util.getAsInt(dateSplit2[2], 0);
		
		int hour = Util.getAsInt(dateSplit3[0], 0);
		int minute = Util.getAsInt(dateSplit3[1], 0);
		
		String format = "";
		if(nowDate.getYear() == year && nowDate.getMonthValue() == month && nowDate.getDayOfMonth() == day) {		
			format = dateSplit3[0] + ":" + dateSplit3[1];
		} else {
			format = dateSplit2[0] + "." + dateSplit2[1] + "." + dateSplit2[2] + ".";
		}
		
		return format;
	}
	
	public static String setBoardName(String boardName) {
		if(boardName.length() > 2)
			boardName = boardName.substring(0, 2);
		return boardName;
	}
}
