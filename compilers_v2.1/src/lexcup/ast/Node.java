/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package ast;


/**
 *
 * @author suneeta
 */
public abstract class Node {
    public Node left;
    public Node right;

    public abstract Object accept(Visitor v);

}
