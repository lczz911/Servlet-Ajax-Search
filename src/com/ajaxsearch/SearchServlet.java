package com.ajaxsearch;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet {
	
	static List<String> datas = new ArrayList<String>();
	//ģ������
	static {
		
		datas.add("ajax");
		datas.add("ajax post");
		datas.add("ajax get");
		datas.add("ajax test");
		datas.add("boot01");
		datas.add("boot02");
		datas.add("boot03");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		//System.out.println("123");
		//��ÿͻ��˷��͹�����keyword
		String keyword = request.getParameter("keyword");
		//�Ի�õĹؼ��ֽ��д�����ù�������
		List<String> listData = getData(keyword);
		//����json��ʽ
		//System.out.println(JSONArray.fromObject(listData));
		response.getWriter().write(JSONArray.fromObject(listData).toString());
	}
	
	//��ù������ݵķ���
	public List<String> getData(String keyword){
		List<String> list = new ArrayList<String>();
		for (String data : datas) {
			if(data.contains(keyword)) {
				list.add(data);
			}
		}
		return list;
	}
}
