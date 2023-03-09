function mergeCell(tableId, gubn){
    
        var first = true;
        var prevRowspan1 = 1;
        var prevCellSeq = null;
        var prevRowspan2 = 1;
        var prevCellServiceName = null;
        var prevRowspan3 = 1;
        var prevCellAccountId = null;
        var rows = null;

        if(gubn == "ID")
        rows = $("#" + tableId + " > tbody").children();
        else
        rows = $("[name='" + tableId + "'] > tbody").children();

        for(var i = 0; i < rows.length; i++){
            if(first){
                prevRow = rows[i];
                prevCellSeq = $(prevRow).find("td").eq(0);
                prevCellServiceName = $(prevRow).find("td").eq(1);
                prevCellAccountId = $(prevRow).find("td").eq(2);


                first = false;
                continue;
            }

            var row = rows[i];
            var tdList = $(row).find("td");

            var seqCell = $(tdList).eq(0);
            var serviceNameCell = $(tdList).eq(1);
            var accountIdCell = $(tdList).eq(2);

            var seqCellText = $(seqCell).text();
            var serviceNameCellText = $(serviceNameCell).text();
            var accountIdCellText = $(accountIdCell).text();

            if(prevCellSeq.text() == seqCellText) {
                if(prevCellServiceName.text() == serviceNameCellText){                    
                    if(prevCellAccountId.text() == accountIdCellText){
                        prevRowspan3++;
                        $(prevCellAccountId).attr("rowspan", prevRowspan3);
                        $(accountIdCell).remove();
                    }else{
                        prevRowspan3 = 1;
                        prevCellAccountId = accountIdCell;
                    }
                    prevRowspan2++;
                    $(prevCellServiceName).attr("rowspan", prevRowspan2);
                    $(serviceNameCell).remove();                
                }else{
                    prevRowspan2 = 1;
                    prevRowspan3 = 1;
                    prevCellServiceName = serviceNameCell;
                    prevCellAccountId = accountIdCell;
                }
                prevRowspan1++;
                $(prevCellSeq).attr("rowspan", prevRowspan1);
                $(seqCell).remove();    
            }else{
                prevRowspan1 = 1;
                prevRowspan2 = 1;
                prevRowspan3 = 1;
                prevCellSeq = seqCell;
                prevCellServiceName = serviceNameCell;
                prevCellAccountId = accountIdCell;
            }            
        }
}
