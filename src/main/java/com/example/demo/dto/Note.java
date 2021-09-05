package com.example.demo.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {
	int nid;
	int sUid;
	int rUid;
	String body;
	String regDate;
	int sDelState;
	int rDelState;
	boolean read;
	
	String nickname;
	
	public String getBody() {
		return this.transContent(body);
	}
	
	public String transContent(String str) {
		str = str.replace("<", "&lt");
		str = str.replace(">", "&gt");
		
		return str;
	}
}