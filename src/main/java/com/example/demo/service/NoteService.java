package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.NoteDao;

@Service
public class NoteService {
	@Autowired
	NoteDao nd;
	
	public void send(int sUid, int rUid, String body) {
		
		nd.send(sUid, rUid, body);
	}
	
}
