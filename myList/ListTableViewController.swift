
import UIKit
import CoreData

class ListTableViewController: UITableViewController {

    var myList : Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context : NSManagedObjectContext = appDel.managedObjectContext!;
        let freq = NSFetchRequest(entityName: "List");
        
        myList = context.executeFetchRequest(freq, error: nil)!
        tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "update") {
            var index = self.tableView.indexPathForSelectedRow()?.row;
            var selectedItem : NSManagedObject = myList[index!] as NSManagedObject
            
            let IVC : ItemViewController = segue.destinationViewController as ItemViewController
            IVC.item = selectedItem.valueForKey("item") as String;
            IVC.quantity = selectedItem.valueForKey("quantity") as String;
            IVC.info = selectedItem.valueForKey("info") as String;
            IVC.existingItem = selectedItem
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count;
    }

    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        
        // configure the cell.
        let CellID : NSString = "Cell"; // match what's been defined in the storyboard.
        var cell : UITableViewCell = tableView?.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell;
        
        if let ip = indexPath {
            var data : NSManagedObject = myList[ip.row] as NSManagedObject;
            cell.textLabel?.text = data.valueForKey("item") as? String;
            
            var qnt = data.valueForKey("quantity") as String;
            var info = data.valueForKey("info") as String;
            var details : String = "\(qnt) item/s - \(info)";
            cell.detailTextLabel?.text = details;
        }
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        let appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate;
        let context : NSManagedObjectContext = appDel.managedObjectContext!;

        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            if let tv = tableView {
                let index = indexPath!.row;
                context.deleteObject(myList[index] as NSManagedObject)
                myList.removeAtIndex(index)
                tv.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var error : NSError? = nil;
            if (!context.save(&error)) {
                abort();
            }
            
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
