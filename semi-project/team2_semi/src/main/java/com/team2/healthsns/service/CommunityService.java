package com.team2.healthsns.service;

import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;

import java.util.List;

public interface CommunityService {
    public int CommunityInsertAuth(CommunityVO vo);
    public List<CommunityVO> CommunityPageListAuth(PagingVO pVO);
    public int totalRecordAuth(PagingVO pVO);
    public CommunityVO CommunitySelectAuth(int no);
    public void hitCountAuth(int no);
    public int CommunityUpdateAuth(CommunityVO vo);
    public int CommunityDeleteAuth(int no);

    public int CommunityInsertFree(CommunityVO vo);
    public List<CommunityVO> CommunityPageListFree(PagingVO pVO);
    public int totalRecordFree(PagingVO pVO);
    public CommunityVO CommunitySelectFree(int no);
    public void hitCountFree(int no);
    public int CommunityUpdateFree(CommunityVO vo);
    public int CommunityDeleteFree(int no);

    public int CommunityInsertQa(CommunityVO vo);
    public List<CommunityVO> CommunityPageListQa(PagingVO pVO);
    public int totalRecordQa(PagingVO pVO);
    public CommunityVO CommunitySelectQa(int no);
    public void hitCountQa(int no);
    public int CommunityUpdateQa(CommunityVO vo);
    public int CommunityDeleteQa(int no);
}
