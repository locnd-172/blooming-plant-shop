package locnd.dto;

import locnd.dao.DAOAccount;
import java.util.ArrayList;
import locnd.dao.DAOPlant;

/**
 *
 * @author Loc NgD <locndse160199@fpt.edu.vn>
 */
public class testConnection {

    public static void main(String[] args) {
        Account acc;
        acc = DAOAccount.getAccount("test@gmail.com", "test");
        if (acc != null) {
            if (acc.getRole() == 1) 
                System.out.println("I'm an admin");
            else 
                System.out.println("I'm an user");
        } else {
            System.out.println("login fail");
        }
        
        // test get plant list
        ArrayList<Plant> list = DAOPlant.getPlants("or", "bycate");
        for (Plant plant : list) {
            System.out.println(plant.toString());
        }
        
//        // test get account list
//        ArrayList<Account> list = DAOAccount.getAccounts();
//        list.forEach((account) -> {
//            System.out.println(account.toString());
//        });
//        
//        // test update user status
//        if (DAOAccount.updateAccountStatus("test@gmail.com", 1))
//            System.out.println("update status successfully");
//        else 
//            System.out.println("cannot update status");
//        
//        // test update profile
//        if (DAOAccount.updateAccount("test@gmail.com", "999999", "pipi", "654321")) 
//            System.out.println("profile updated");
//        else 
//            System.out.println("update fail");
//        
//        if (DAOAccount.insertAccount("test2@gmail.com", "111111", "dolphin", "101011", 1, 0))
//            System.out.println("insert new account successfully");
//        else 
//            System.out.println("insert new accoutn fail");
    }
    
}
