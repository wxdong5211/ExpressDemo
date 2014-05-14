var beforeDrag = function(treeId, treeNodes) {
    for (var i=0,l=treeNodes.length; i<l; i++) {
        if (treeNodes[i].drag === false) {
            return false;
        }
    }
    return true;
};

var beforeDrop = function (treeId, treeNodes, targetNode, moveType) {
    var targetParent,origParent,origParentId;
    targetParent = moveType==='inner' ? targetNode : targetNode.getParentNode();
    origParent = treeNodes[0].getParentNode() === null ? 'root' : treeNodes[0].getParentNode().name;
    origParentId = treeNodes[0].getParentNode() === null ? '-1' : treeNodes[0].getParentNode().id;
    console.log(origParent+':'+origParentId+'->'+ (targetParent===null ? 'root:-1' :targetParent.name+':'+targetParent.id));
    return targetNode ? targetNode.drop !== false : true;
};

var beforeEditName = function(treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("depa");
    zTree.selectNode(treeNode);
    return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
};

var onRename = function(e, treeId, treeNode) {
};
var showRemoveBtn = function(treeId, treeNode) {
    return !treeNode.isFirstNode;
};
var showRenameBtn = function(treeId, treeNode) {
    return !treeNode.isLastNode;
};
var newCount = 1;
var addHoverDom = function(treeId, treeNode) {
    var sObj = $("#" + treeNode.tId + "_span");
    if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
    var addStr = "<span class='button add' id='addBtn_" + treeNode.id
        + "' title='add node' onfocus='this.blur();'></span>";
    sObj.after(addStr);
    var btn = $("#addBtn_"+treeNode.id);
    if (btn) btn.bind("click", function(){
        var zTree = $.fn.zTree.getZTreeObj("depa");
        zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"new node" + (newCount++)});
        return false;
    });
};
var removeHoverDom = function(treeId, treeNode) {
    $("#addBtn_"+treeNode.id).unbind().remove();
};
var selectAll = function() {
    var zTree = $.fn.zTree.getZTreeObj("depa");
    zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
};

var beforeRemove = function(treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("depa");
    zTree.selectNode(treeNode);
    return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
};
var onRemove = function (e, treeId, treeNode) {
};
var beforeRename = function(treeId, treeNode, newName) {
    if (newName.length == 0) {
        alert("节点名称不能为空.");
        var zTree = $.fn.zTree.getZTreeObj("depa");
        setTimeout(function(){zTree.editName(treeNode)}, 10);
        return false;
    }
    return true;
};

var OnRightClick = function(event, treeId, treeNode) {
    var zTree = $.fn.zTree.getZTreeObj("depa");
    if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
        zTree.cancelSelectedNode();
        showRMenu("root", event.clientX, event.clientY);
    } else if (treeNode && !treeNode.noR) {
        zTree.selectNode(treeNode);
        showRMenu("node", event.clientX, event.clientY);
    }
};

var showRMenu = function(type, x, y) {
    $("#rMenu ul").show();
    if (type=="root") {
        $("#m_del").hide();
        $("#m_check").hide();
        $("#m_unCheck").hide();
    } else {
        $("#m_del").show();
        $("#m_check").show();
        $("#m_unCheck").show();
    }
    $("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"});
    $("body").bind("mousedown", onBodyMouseDown);
};

var hideRMenu = function() {
    $("#rMenu").css({"visibility": "hidden"});
    $("body").unbind("mousedown", onBodyMouseDown);
};
var onBodyMouseDown = function(event){
    if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
        $("#rMenu").css({"visibility" : "hidden"});
    }
};
var addCount = 1;
var addTreeNode = function () {
    hideRMenu();
    var newNode = { name:"增加" + (addCount++)};
    var zTree = $.fn.zTree.getZTreeObj("depa");
    if (zTree.getSelectedNodes()[0]) {
        newNode.checked = zTree.getSelectedNodes()[0].checked;
        zTree.addNodes(zTree.getSelectedNodes()[0], newNode);
    } else {
        zTree.addNodes(null, newNode);
    }
};
var removeTreeNode = function () {
    hideRMenu();
    var zTree = $.fn.zTree.getZTreeObj("depa");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes.length>0) {
        if (nodes[0].children && nodes[0].children.length > 0) {
            var msg = "要删除的节点是父节点，如果删除将连同子节点一起删掉。\n\n请确认！";
            if (confirm(msg)==true){
                zTree.removeNode(nodes[0]);
            }
        } else {
            zTree.removeNode(nodes[0]);
        }
    }
};
var checkTreeNode = function (checked) {
    var zTree = $.fn.zTree.getZTreeObj("depa");
    var nodes = zTree.getSelectedNodes();
    if (nodes && nodes.length>0) {
        zTree.checkNode(nodes[0], checked, true);
    }
    hideRMenu();
};

var setting = {
    view: {
        addHoverDom: addHoverDom,
        removeHoverDom: removeHoverDom,
        selectedMulti: false
    },
//    check: {
//        enable: true
//    },
    edit: {
        enable: true,
        editNameSelectAll: true,
        showRemoveBtn: showRemoveBtn,
        showRenameBtn: showRenameBtn
    },
    data: {
        simpleData: {
            enable: true
        }
    },
    callback: {
        beforeDrag: beforeDrag,
        beforeDrop: beforeDrop,
        beforeEditName: beforeEditName,
        beforeRemove: beforeRemove,
        beforeRename: beforeRename,
        onRemove: onRemove,
        onRename: onRename,
        onRightClick: OnRightClick
    }
};