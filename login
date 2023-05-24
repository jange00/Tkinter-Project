#login
from tkinter import*
import tkinter.font as font 
#This library allows you to work with fonts in your tkinter-based GUI application. 
#It provides a way to create, customize, and use different fonts for text elements such as labels, buttons, and text boxes in your application's user interface. 
from PIL import ImageTk, Image
# it allows you to work with images in the Python Imaging Library (PIL) using the tkinter library.
from re import A
#allows you to import the 'A' constant from the 're' module in Python.
import sqlite3
#allows you to use the sqlite3 module, which provides functionality for working with SQLite databases.
from tkinter import messagebox
#which provides functionality for working with SQLite databases.
from functools import partial
window= Tk()
window.title("Login")
window.configure(bg="#FFFF7F")
window.geometry("900x500")
font1=font.Font(family='Georgia')
font2=font.Font(family="Georgia", size=8)
window.resizable(0,0)

frame=Frame(window,width=300,height=350,bg='#fff', borderwidth=3)
frame.place(x=550,y=100)
femail=1
fpassword=1
def opensignup():
    window.destroy()  #refers to the tkinter window object that you want to close. 
    import Sign_up

def opendash():
    window.destroy()
    import dash
    
#Read and verify the DB information
def check():
        a=Email.get() #used to retrieve the value entered in an email input field in tkinter.
        b=Password.get()
        try:
            con=sqlite3.connect("client.db")
            c=con.cursor()
            c.execute("SELECT * FROM users")
            record=c.fetchall() #used in Python's SQLite database programming to retrieve all the rows of data returned by a database query.
            i = len(record)-1
            while i>=0:
                if record[i][2]!=a or record [i][3]!=b:
                    i = i-1
                    if i == -1:
                        messagebox.showerror("Login","Invalid")
                        break
                    else:
                        c.execute("""UPDATE users SET
                        satus =:inactive 
                        WHERE status=:active""",
                        {"inactive":False,
                        "active":True})
                        con.commit()  #used in Python's SQLite database programming to save or commit the changes made to the database.
                        
                        
                        c.execute("""UPDATE users SET
                        status=:val
                        WHERE Email =:a""",
                        {
                            'val':True,
                            'a':a 
                        })
                        con.commit()
                        messagebox.showerror("Login","Sign Up First")
                        break
                con.comit()
                con.close()
        except:
            messagebox.showerror("Login","Sign Up First")
            
def enter(event):
    global femail
    if (femail == 1):
        if(Email.get() == "Email"):
            Email.delete(0,END)
            return
        femail = 2
def leave(event):
    if Email.get()=='':
        Email.insert(0,"Email")
Email=Entry(frame,width=23,bd=5,font=('Comic Sans MS',12,'bold'))
Email.place(x=50,y=75)
Email.insert(1,"Email")
Email.bind('<FocusIn>',enter) #that it becomes the active element that can receive user input.
Email.bind('<FocusOut>',leave) #meaning that it is no longer the active element that can receive user input.


def enter(evnet):
    global fpassword
    if (fpassword == 1):
        if (Password.get() == "Password"):
            Password.delete(0,END)
            return
        fpassword = 2
def leave(event):
    if Password.get()=="":
        Password.insert(0,"Password")
Password=Entry(frame,width=23,bd=5,font=('Comic Sans MS',12,'bold'))
Password.place(x=50,y=120)
Password.insert(2,'Password')
Password.bind("<FocusIn>",enter)      
Password.bind('<FocusOut>',leave) 
heading=Label(frame,text="Login",fg='red',bg='white',font=('Gabriola','25','bold'))
heading.place(x=110,y=5)

    #login button
bt1=Button(frame,text="LOGIN",font=('Comic Sans MS',10,'bold'),fg='white',bg="#338bd7",width=16,height=2,cursor='hand2', command= check)
bt1.place(x=75,y=180)
btn2=Button(frame,text="SignUp",font=("Roboto","9","bold"),bd=0,fg="blue",bg="white", command= opensignup).place(x=170,y=250)
signup_label= Label(window, text="Create new account?",font= font2,bg='white' )
signup_label.place(x=570,y=350)
window.mainloop()






    

