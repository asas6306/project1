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
}