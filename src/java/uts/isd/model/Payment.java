/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uts.isd.model;

/**
 *
 * @author Administrator
 */
public class Payment {
    private int paymentNo;
    private String paymentType;
    private int paymentNumber;

    public Payment(int paymentNumber, String type, int number) {
        this.paymentNo = paymentNumber;
        this.paymentType = type;
        this.paymentNumber = number;
    }

    public void setPaymentNo(int paymentNo) {
        this.paymentNo = paymentNo;
    }

    public int getPaymentNo() {
        return paymentNo;
    }
    
    public String getPaymentType() {
        return paymentType;
    }

    public int getPaymentNumber() {
        return paymentNumber;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public void setPaymentNumber(int paymentNumber) {
        this.paymentNumber = paymentNumber;
    }
    
    @Override
    public String toString() {
        return "" + paymentNo + " " + paymentType + " " + paymentNumber;
    }
}
