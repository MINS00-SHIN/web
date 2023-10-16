package com.team2.healthsns.service;

import com.team2.healthsns.mapper.CommunityAuthMapper;
import com.team2.healthsns.mapper.CommunityFreeMapper;
import com.team2.healthsns.mapper.CommunityQaMapper;
import com.team2.healthsns.vo.CommunityVO;
import com.team2.healthsns.vo.PagingVO;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Service
public class CommunityServicempl implements CommunityService{

    @Inject
    CommunityAuthMapper authMapper;

    @Override
    public int CommunityInsertAuth(CommunityVO vo) {
        return authMapper.communityInsertAuth(vo);
    }

    @Override
    public List<CommunityVO> CommunityPageListAuth(PagingVO pVO) {
        return authMapper.communityPageListAuth(pVO);
    }

    @Override
    public int totalRecordAuth(PagingVO pVO) {
        return authMapper.totalRecordAuth(pVO);
    }

    @Override
    public CommunityVO CommunitySelectAuth(int post_id) {
        return authMapper.communitySelectAuth(post_id);
    }

    @Override
    public void hitCountAuth(int post_id) {
        authMapper.hitCountAuth(post_id);
    }

    @Override
    public int CommunityUpdateAuth(CommunityVO vo) {
        return authMapper.communityUpdateAuth(vo);
    }

    @Override
    public int CommunityDeleteAuth(int post_id) {
        return authMapper.communityDeleteAuth(post_id);
    }

    @Override
    public void increaseLike(int post_id){
        authMapper.increaseLike(post_id);
    }


    @Inject
    CommunityQaMapper qaMapper;
    
    @Override
    public int CommunityInsertQa(CommunityVO vo) {
        return qaMapper.communityInsertQa(vo);
    }

    @Override
    public List<CommunityVO> CommunityPageListQa(PagingVO pVO) {
        return qaMapper.communityPageListQa(pVO);
    }

    @Override
    public int totalRecordQa(PagingVO pVO) {
        return qaMapper.totalRecordQa(pVO);
    }

    @Override
    public CommunityVO CommunitySelectQa(int post_id) {
        return qaMapper.communitySelectQa(post_id);
    }

    @Override
    public void hitCountQa(int post_id) {
        qaMapper.hitCountQa(post_id);
    }

    @Override
    public int CommunityUpdateQa(CommunityVO vo) {
        return qaMapper.communityUpdateQa(vo);
    }

    @Override
    public int CommunityDeleteQa(int post_id) {
        return qaMapper.communityDeleteQa(post_id);
    }


    @Inject
    CommunityFreeMapper freeMapper;
    
    @Override
    public int CommunityInsertFree(CommunityVO vo) {
        return freeMapper.communityInsertFree(vo);
    }

    @Override
    public List<CommunityVO> CommunityPageListFree(PagingVO pVO) {
        return freeMapper.communityPageListFree(pVO);
    }

    @Override
    public int totalRecordFree(PagingVO pVO) {
        return freeMapper.totalRecordFree(pVO);
    }

    @Override
    public CommunityVO CommunitySelectFree(int post_id) {
        return freeMapper.communitySelectFree(post_id);
    }

    @Override
    public void hitCountFree(int post_id) {
        freeMapper.hitCountFree(post_id);
    }

    @Override
    public int CommunityUpdateFree(CommunityVO vo) {
        return freeMapper.communityUpdateFree(vo);
    }

    @Override
    public int CommunityDeleteFree(int post_id) {
        return freeMapper.communityDeleteFree(post_id);
    }
}
