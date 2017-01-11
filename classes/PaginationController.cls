/**************************************************************************************
 * Create By:   Deloitte Consulting LLP.
 * CreateDate:  21-Sep-2015
 * Description: This is controller class for handling Pagination in the vf pages. It is a virtual class, so all the methods and variables can be 
 * reused in all pages and controllers            
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                 Created Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Vishal Negandhi           24-Sep-2015                   Initial version.
 **************************************************************************************/
public virtual class PaginationController {
	// for pagination
    public Integer PageSize    {get;set;}
    public Integer CurrentPage    {get;set;}
    public String CurrentPageInfo    {get;set;}
    
    // for disabling pagination links
    public Boolean ShowPrevious    {get;set;}
    public Boolean ShowNext    {get;set;}
    
    public Integer TotalRecords;
    public Integer PageNumber;
    
    public PaginationController(){
    	PageSize = 2;
    	CurrentPage = 1;
    	CurrentPageInfo = '';
    	ShowPrevious = false;
    	ShowNext = false;
    	
    	TotalRecords = 5;
    	PageNumber = 1;	
    }
    
    public void showPrevious()
    {
        CurrentPage = CurrentPage - PageSize;
        PageNumber--;
        enableDisablePaginationLinks();        
    }
    
    public void showNext()
    {
        CurrentPage = CurrentPage + PageSize;
        PageNumber++;
        enableDisablePaginationLinks();
    }
    
    public void showFirst()
    {
        CurrentPage = 0;
        PageNumber = 1;
        enableDisablePaginationLinks();
    }
    
    public void showLast()
    {
        CurrentPage = (Math.mod(TotalRecords, PageSize) == 0) ? TotalRecords - PageSize : (TotalRecords / PageSize) * PageSize;
        PageNumber = (Math.mod(TotalRecords, PageSize) == 0 ? TotalRecords/PageSize : (TotalRecords/PageSize) + 1);
        enableDisablePaginationLinks();
    }
    
    private void enableDisablePaginationLinks()
    {
        if(CurrentPage == 0)
            ShowPrevious = false;
        else
            ShowPrevious = true;
        
        if((TotalRecords - PageSize) <= CurrentPage)
            ShowNext = false;
        else
            ShowNext = true;
        
        if(TotalRecords < 1)
        	PageNumber = 0;
        
        CurrentPageInfo = 'Showing Page ' + PageNumber +   ' of ' + (Math.mod(TotalRecords, PageSize) == 0 ? TotalRecords/PageSize : (TotalRecords/PageSize) + 1);
    }
}