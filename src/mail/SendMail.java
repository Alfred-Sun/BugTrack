package mail;
//import java.io.*; 
import java.io.FileOutputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/*
 * �ʼ����ͳ���
 * ʹ��JavaMail����һ��򵥵��ʼ���
 * 1�����������ʼ�������������������Ϣ��Session���� 
 * 2�����������ʼ����ݵ�Message���� 
 * 3������Transport�������ӷ�����������Message���ر����ӡ� 
 * �����Դ�CSACHUST@126.com   ���룺HUSTACCS  �� symdfbb@sina.com ��һ�����ͼƬ���ʼ�Ϊ�����������£�
 */

public class SendMail {
	private String user = null;
	private String email = null;
	private String bugid = null;
	// send e-mail
	public SendMail(String assign_to, String email, String id) {
//		String assign_to=(String)request.getParameter("assign_to");
		setUsername(assign_to);
		setEmailname(email);
		setBugid(id);
	    // ��������
		Properties props = new Properties();
		props.setProperty("mail.host", "smtp.126.com");
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.smtp.auth", "ture");
	
		Session session = Session.getInstance(props);
		Message message = CreatMessage(session);
	
		try {
			Transport trs = session.getTransport();
			trs.connect("CSACHUST", "HUSTACCS");
			trs.sendMessage(message, message.getAllRecipients());
			trs.close();
			System.out.println("Email send end !");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//�����ʼ�
	public Message CreatMessage(Session session){
		
	   MimeMessage message=new MimeMessage(session);
	   try {
			//��������
			message.setFrom(new InternetAddress("CSACHUST@126.com"));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
			// �����ʼ���
			// �ʼ�������
			message.setSubject("From BugTrack: NEW BUG TASKS !");
			// ����
			MimeBodyPart part = new MimeBodyPart();
			part.setContent("Hi,"+user+".<br/><br/>The administrator has assigned a new bug task to you, and please login in the BugTrack System to fix it.<br/><br/>Thanks !", "text/html;charset=iso-8859-1");
			// ������ϵ
			MimeMultipart mm = new MimeMultipart();
			mm.addBodyPart(part);
			// ����
			message.setContent(mm);
			message.saveChanges();
			message.writeTo(new FileOutputStream("C:/bug"+bugid+".eml"));

	   } catch (Exception e) {
	       e.printStackTrace();
	   }
	   return message;
	}
	public void setUsername(String name) {
		user = name;
	}
	public void setEmailname(String name) {
		email = name;
	}
	public void setBugid(String id) {
		bugid = id;
	}
}
