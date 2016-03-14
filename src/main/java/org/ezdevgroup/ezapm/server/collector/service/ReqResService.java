package org.ezdevgroup.ezapm.server.collector.service;

import org.ezdevgroup.ezapm.server.ds.tams.ReqResMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by ddakker on 2016-03-07.
 */
@Service
public class ReqResService {
    private static Logger log = LoggerFactory.getLogger(ReqResService.class);
	
    @Resource
    ReqResMapper reqResMapper;

    public void addReq(Map<String, Object> params) {
        /*try {
            if (reqResMapper.addReq(params) == 0) {
                throw new RuntimeException("등록 갯수 0 params: " + params);
            }
        } catch (Exception e) {
            log.error("등록 실패", e);
        }*/
    }

    public void modifyRes(Map<String, Object> params) {
        /*try {
            if (reqResMapper.modifyRes(params) == 0) {
                throw new RuntimeException("수정 갯수 0 params: " + params);
            }
        } catch (Exception e) {
            log.error("수정 실패", e);
        }*/
    }
}
