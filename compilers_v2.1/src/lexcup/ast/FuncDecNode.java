/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ast;

/**
 *
 * @author suneeta
 */
public class FuncDecNode extends Node{
    public String id;
    public GNode paramList;
    public String outType;


    public FuncDecNode(String id,GNode paramList,String outType, GNode body)
    {
            this.id = id;
            this.paramList = paramList;
            this.outType = outType;
            this.left = body.left;
            this.right = body.right;

    }

    public Object accept(Visitor v) {
        return v.visit(this);
    }

}
