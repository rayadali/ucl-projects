/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ast;

/**
 *
 * @author suneeta
 */
public class ParamNode extends Node{
    public String id;
    public String type;

    public ParamNode(String id, String type)
    {
        this.id = id;
        this.type = type;
        this.left = null;
        this.right = null;
    }

    @Override
    public Object accept(Visitor v) {

        return v.visit(this);
    }

}
