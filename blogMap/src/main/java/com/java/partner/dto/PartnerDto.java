package com.java.partner.dto;

import java.util.Date;
/**
 * @name: PartnerDto
 * @date:2015. 7. 3.
 * @author: 변태훈
 * @description: partner DB 변수선언
 */
public class PartnerDto {

   private int partner_no;
   private String member_id;
   private String category_code;
   private String partner_name;
   private String partner_phone;
   private String partner_addr;
   private Date partner_rgdate;
   private String partner_yn;
   private Date partner_ydate;
   private String partner_pic_name;
   private String partner_pic_path;
   private long partner_pic_size;
   
   
   public int getPartner_no() {
      return partner_no;
   }
   
   public void setPartner_no(int partner_no) {
      this.partner_no = partner_no;
   }
   
   public String getMember_id() {
      return member_id;
   }
   
   public void setMember_id(String member_id) {
   	   this.member_id = member_id;
   }
   
   public String getCategory_code() {
      return category_code;
   }
   
   public void setCategory_code(String category_code) {
      this.category_code = category_code;
   }
   
   public String getPartner_name() {
      return partner_name;
   }
   
   public void setPartner_name(String partner_name) {
      this.partner_name = partner_name;
   }
   
   public String getPartner_phone() {
      return partner_phone;
   }
   
   public void setPartner_phone(String partner_phone) {
      this.partner_phone = partner_phone;
   }
   
   public String getPartner_addr() {
      return partner_addr;
   }
   
   public void setPartner_addr(String partner_addr) {
      this.partner_addr = partner_addr;
   }
   
   public Date getPartner_rgdate() {
      return partner_rgdate;
   }
   
   public void setPartner_rgdate(Date partner_rgdate) {
      this.partner_rgdate = partner_rgdate;
   }
   
   public String getPartner_yn() {
      return partner_yn;
   }
   
   public void setPartner_yn(String partner_yn) {
      this.partner_yn = partner_yn;
   }
   
   public Date getPartner_ydate() {
      return partner_ydate;
   }
   
   public void setPartner_ydate(Date partner_ydate) {
      this.partner_ydate = partner_ydate;
   }
   
   public String getPartner_pic_name() {
      return partner_pic_name;
   }
   
   public void setPartner_pic_name(String partner_pic_name) {
      this.partner_pic_name = partner_pic_name;
   }
   
   public String getPartner_pic_path() {
      return partner_pic_path;
   }
   
   public void setPartner_pic_path(String partner_pic_path) {
      this.partner_pic_path = partner_pic_path;
   }
   
   public long getPartner_pic_size() {
      return partner_pic_size;
   }
   
   public void setPartner_pic_size(long fileSize) {
      this.partner_pic_size = fileSize;
   }
}
