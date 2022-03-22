<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Management</title>
    </head>
    <body>
        <c:if test="${users ne null}">
        <h2>Manage User</h2>
        <table>
            <tr>
                <td>Email</td>
                <td>First Name</td>
                <td>Last Name</td>
                <td>Role</td>
                <td>Active</td>
                <td>Edit</td>
                <td>Delete</td>
            </tr>
             <c:forEach items="${users}" var="user">
                <tr>
                 <td>${user.email}</td>
                 <td>${user.firstName}</td>
                 <td>${user.lastName}</td>
                 <td>${user.role.roleName}</td>
                 <td>
                     <c:if test="${user.active == true}">
                         <input type="checkbox" name="chkBox" checked = "checked">
                     </c:if>
                     <c:if test="${user.active == false}">
                         <input type="checkbox" name="chkBox">
                     </c:if>   
                 </td>
                 <td><a href="users?action=edit&amp;email=${user.email}">Edit</a></td>
                 <td><a href="users?action=delete&amp;email=${user.email}">Delete</a></td>
                </tr>
            </c:forEach>
        </table>
        </c:if>
        <a href="users?action=add">Add User</a>
        <c:if test="${adduser==true}">
            <h2>Add User</h2>
            <form action="users" method="post">
                <table>
                    <tr>
                        <td>Email</td>
                        <td>First Name</td>
                        <td>Last Name</td>
                        <td>Role</td>
                        <td>Active</td>
                        <td>Password</td>
                    </tr>
                    <tr>
                        <td><input type="text" name="email"></td>
                        <td><input type="text" name="fname"></td>
                        <td><input type="text" name="lname"></td>
                        <td>
                            <select name="role">
                                <c:forEach items="${roles}" var="role">
                                    <option value="${role.roleId}">${role.roleName}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <input type="checkbox" id="chk" name="active" value="1" checked="checked"/>
                        </td>
                        <td><input type="password " name="password"></td>
                    </tr>
                </table>
                <input type="hidden" name="action" value="create">
                <input type="submit" value="Add">
                 <a href="users">cancel add</a>
            </form>
        </c:if>
        <c:if test="${selectedUser ne null}">
            <h2>Edit User</h2>
            <form action="users" method="post">
                <table>
                    <tr>
                        <td>Email</td>
                        <td>First Name</td>
                        <td>Last Name</td>
                        <td>Role</td>
                        <td>Active</td>
                        <td>Password</td>
                    </tr>
                    <tr>
                        <td>${selectedUser.email}</td>
                        <td><input type="text" name="fname" value="${selectedUser.firstName}"</td>
                        <td><input type="text" name="lname" value="${selectedUser.lastName}"</td>
                        <td>
                            <select name="role">
                                <c:forEach items="${roles}" var="role">
                                    <!-- 如果下拉列表框的值与当前用户的角色编号相同，则添加给该option标签添加selected属性 -->
                                    <option value="${role.roleId}" <c:if test="${role.roleId == selectedUser.role.roleId}">selected ="selected"</c:if>>${role.roleName}
                                    </option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${selectedUser.active == true}">
                                  <input type="checkbox" id="chk" name="active" 
                                       value="${selectedUser.active}" checked="checked"/>
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" id="chk" name="active" 
                                          value="${selectedUser.active}"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td><input type="password " name="password" value="${selectedUser.password}"</td>
                    </tr>
                </table>
                
                <input type="hidden" name="email" value="${selectedUser.email}">
                <input type="hidden" name="action" value="update">
                <input type="submit" value="Save">
                 <a href="users">cancel edit</a>
            </form>
        </c:if>
    </body>
</html>
