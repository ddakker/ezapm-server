package org.ezdevgroup.ezapm.server.collector;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ShareData {
	public static Map<String, List<Long>> resMap = Collections.synchronizedMap(new HashMap<>());
	
	public static void main(String[] args) {
		resMap.put("a", (List<Long>) Collections.EMPTY_LIST);
	}
}
