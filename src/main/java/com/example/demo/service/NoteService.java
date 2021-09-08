package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.NoteDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.Note;

@Service
public class NoteService {
	@Autowired
	NoteDao nd;

	public Note getNote(int nid) {
		
		return nd.getNote(nid);
	}
	
	public void send(int sUid, int rUid, String body) {
		
		nd.send(sUid, rUid, body);
	}

	public int getNotesCnt(int uid, String noteType) {
		
		return nd.getNotesCnt(uid, noteType);
	}

	public List<Article> getNotes(int page, int pageCnt, String noteType, int uid) {
		
		return nd.getNotes(page, pageCnt, noteType, uid);
	}

	public void delete(int nid, String noteType) {
		System.out.println("test!" + noteType);
		nd.delete(nid, noteType);
	}

	public int getNewNoteCnt(int uid) {
		
		return nd.getNewNoteCnt(uid);
	}

	public void doRead(int nid) {
		
		nd.doRead(nid);
	}

	
}
