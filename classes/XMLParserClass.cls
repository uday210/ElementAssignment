public class XMLParserClass{

    public Map<String, String> xmlDataMap = new Map<String,String>(); 

    private void iterateThroughXML(DOM.XMLNode node){
//system.debug(node.getNodeType());
        if (node.getNodeType() == DOM.XMLNodeType.ELEMENT){
  //      system.debug('node.getName() '+node.getName());
            if(node.getName().equalsIgnoreCase('sessionId')){
              
              xmlDataMap.put(node.getname(),node.getText());
               // if (node.getAttributeCount() > 0) {
                 // xmlDataMap.put(node.getAttributeValue(node.getAttributeKeyAt(0), node.getAttributeKeyNsAt(0)), node.getAttributeValue(node.getAttributeKeyAt(1), node.getAttributeKeyNsAt(1)));
                //}
           }

            for (Dom.XMLNode child: node.getChildElements())
              iterateThroughXML(child);
        }
    }

    public void parserXML(String toParse){

        xmlDataMap = new Map<String,String>();
        DOM.Document doc = new DOM.Document();
        
        try{
        
            doc.load(toParse);
            DOM.XMLNode root = doc.getRootElement();
            iterateThroughXML(root);
        }catch(Exception ex){

            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, ex.getMessage());
            ApexPages.addMessage(msg);
       } 
    }
}