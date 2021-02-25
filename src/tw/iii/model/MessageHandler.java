package tw.iii.model;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Component
public class MessageHandler extends TextWebSocketHandler {

    private List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    //統計總共有多少CSRF Token用來代表人數
    private HashMap<String , String> userMap = new HashMap<String, String>();
  
    private boolean change = true; 
    private   String user;
    private TextMessage message;
    

    //關閉連線 刪除session
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        sessions.remove(session); //從List中移除
        userMap.remove(session.getId());//從HashMap中移除
        for(WebSocketSession wss : sessions) { 
        	if(session.getPrincipal().getName().equals("qwerty")) {   
        		//wss.sendMessage( new TextMessage ("管理員離開聊天室了" ));
        	 JSONObject jsonObj  = new JSONObject();
       		  jsonObj.put("header","目前有"+sessions.size()+"名成員在線上");
       		 jsonObj.put("value","管理員離開聊天室了");
       		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
        		
            	}else {
        //	wss.sendMessage( new TextMessage (session.getPrincipal().getName()+"離開聊天室了......" ));
        	 JSONObject jsonObj  = new JSONObject();
      		  jsonObj.put("value",session.getPrincipal().getName()+"離開聊天室了......" );
      		  jsonObj.put("header","目前有"+sessions.size()+"名成員在線上");
      		
      		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
            	}
        }
        
    }

    //連線成功 新增session
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	
    	Object sessionType = session.getAttributes().get("user");
    	System.out.println(sessionType);
    
        sessions.add(session);

        
        for(WebSocketSession wss : sessions) { 
        	if(session.getPrincipal().getName().equals("qwerty")) {   
        		
        //	wss.sendMessage( new TextMessage ("管理員上線了" ));  
        	 JSONObject jsonObj  = new JSONObject();
     		  jsonObj.put("header","管理員上線了");
     		
     		 jsonObj.put("value","");
     		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
        	}else {
        	//wss.sendMessage( new TextMessage (session.getPrincipal().getName()+"會員上線了......" ));   
        	
        	 JSONObject jsonObj  = new JSONObject();
    		  jsonObj.put("header",session.getPrincipal().getName()+"會員上線了......");
    		
    		 jsonObj.put("value","");
    		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
        	
        	}
        	 JSONObject jsonObj  = new JSONObject();
   		  jsonObj.put("header","目前有"+sessions.size()+"名成員在線上");
   		 jsonObj.put("value","");
   		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
        	//wss.sendMessage( new TextMessage ("目前有"+sessions.size()+"名成員在線上......" ));
        }
      
    }


	
    
    @Override public boolean supportsPartialMessages() {
    	return false;
    	}

   

    
    //處理用戶發送的訊息 再回傳給其他用戶
    //這裡只回傳人數統計
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	
    	  WebSocketSession he = session ;
//    	JSONObject json = new JSONObject();
    	JSONObject  js = JSONObject.fromObject(message.getPayload()); 
    	System.out.println("類型是="+js.get("type"));
    	System.out.println("內容是="+js.get("text"));
    	System.out.println("id是="+js.get("id"));
    	String towho=js.get("id").toString();
    	if(towho.equals("管理員")) {    					
			towho= "qwerty";
		}
     	for(WebSocketSession wsss : sessions) { 			
		      if(wsss.getPrincipal().getName().equals(towho)) {
				 he=wsss;
		      }
      	}	
    	if(js.get("type").equals("all")) {
    		
            for(WebSocketSession wss : sessions) {
               // wss.sendMessage(new TextMessage(onlineUsersNumber)); 
            	if(session.getPrincipal().getName().equals("qwerty")) {
            	//	wss.sendMessage(new TextMessage("管理員："+js.get("text")));	            		
            		  JSONObject jsonObj  = new JSONObject();
            		  jsonObj.put("header","管理員：");
            		  jsonObj.put("value",js.get("text"));
            		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj)  ) );	 
            		
            	}  else {
            	//	wss.sendMessage(new TextMessage(session.getPrincipal().getName()+":"+js.get("text")));		
            		 JSONObject jsonObj  = new JSONObject();
           		  jsonObj.put("header",session.getPrincipal().getName()+":");
           		  jsonObj.put("value",js.get("text"));
           		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj)  ) );	 
            		
            	}  	
        			
         }
            
    	}if(js.get("type").equals("one")) {
    		for(WebSocketSession wss : sessions) { 	
    		
    		if(wss.getPrincipal().getName().equals(session.getPrincipal().getName())) {
    			
    			if(he.isOpen() && he!=session) {
    		//	wss.sendMessage(new TextMessage("你對 "+js.get("id")+" 說:"+js.get("text")));	
    				
    			 JSONObject jsonObj  = new JSONObject();
    			 if(towho.equals("qwerty")) {    					
    				 jsonObj.put("header","你對管理員說:");
    			 }else {
    			 jsonObj.put("header","你對 "+towho+" 說:");
    			 }
          		  jsonObj.put("value",js.get("text"));
          		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
    			
    			
    			}else {
    			//	wss.sendMessage(new TextMessage("---"+js.get("id")+"並不在聊天室---"));	
    				
    				
    				 JSONObject jsonObj  = new JSONObject();
    				 if(towho.equals("qwerty")) {    					
        				 jsonObj.put("header","---管理員並不在聊天室---");
        			 }else {
             		  jsonObj.put("header","---"+towho+"並不在聊天室---");
        			 }
             		 jsonObj.put("value","");
             		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
    			
    				
    			}
    			
    		}
    		if(wss.getPrincipal().getName().equals(towho)) {
    		 //	wss.sendMessage(new TextMessage("收到來自:"+session.getPrincipal().getName()+"的訊息:"+js.get("text")));	
    			
    			 JSONObject jsonObj  = new JSONObject();
    			 if(!wss.getPrincipal().getName().equals("qwerty")) {    					
    				 jsonObj.put("header","收到來自管理員的訊息:");
    			 }else {
         		  jsonObj.put("header","收到來自"+session.getPrincipal().getName()+"的訊息:");
    			 }
         		  jsonObj.put("value",js.get("text"));
         		  wss.sendMessage(new TextMessage( String.valueOf(jsonObj) ) );	 
    		}
    			 
    			 
    	 }   		
    	}
    	
   	
    	
    	
    	
        //連線成功時 會傳一個包含csrf token的訊息 將其加入HashMap
        String account = session.getPrincipal().getName();
      System.out.println(session.getAcceptedProtocol());
      System.out.println(session.toString());
     
      
    
//        userMap.put(account, token);

        //計算總共有多少不同的csrftoken
        //將所有CSRF Token放入Set就不會有重複的值
//        Set<String> csrfSet = new HashSet<String>();
//        Set<String> keysSet = userMap.keySet();
//        for(String key : keysSet) {
//            String csrf = userMap.get(key);
//            csrfSet.add(csrf);
//        }

        //目前人數 = CSRF Token的數量
//        String onlineUsersNumber = String.valueOf(csrfSet.size());
        //發送在線人數給所有人
        
        		
//        		else{
//        		
//            		if(wss.getPrincipal().getName().equals("qwerty")) {      
//            			if(wss.isOpen()) {
//            			wss.sendMessage(new TextMessage(account+"："+token));
//            			}
//            		}    		
//            		if(wss.getPrincipal().getName().equals(account)) {        			
//            			wss.sendMessage(new TextMessage(account+"："+token));
//            		} 
//            		
//        		
//            	}      
      
			
        	
    	
          
      
    
        
    }
}