/* Class Name : OrderProductValidationController
 * Description : Prevent User from editing or deleting an Order Product
 * Created By : Raushan Anand
 * Created On : 23-Jan-2016
 *
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                    Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Raushan Anand              23-Jan-2016               Initial version.
 **************************************************************************************/
public class OrderProductValidationController {
    Id orderItemId;
    public OrderProductValidationController(ApexPages.StandardController controller){
        orderItemId = controller.getId();
    }
    
    public PageReference backToOriginal(){
            List<OrderItem> ord= [SELECT Id,OrderId FROM OrderItem where Id=:orderItemId LIMIT 1];
            PageReference orderPage = new PageReference('/'+ ord[0].OrderId);
            return orderPage;
    } 
}