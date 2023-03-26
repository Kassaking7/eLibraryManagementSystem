import { SMTPClient } from 'emailjs';
 
 
export default function handler(req, res) {
 
 const {email}=req.body;
 // console.log(process.env)
 
 const client = new SMTPClient({
   user: process.env.mail,
   password: process.env.password,
   host: 'smtp.gmail.com',
   ssl:true
 });
 
 try{
   client.send(
     {
       text: `Just for testing purpose`,
       from: process.env.mail,
       to: email,
       subject: 'testing emailjs',
      
     }
     )
   }
 catch(e){
   res.status(400).end(JSON.stringify({ message:"Error" }))
   return;
 }
 
 res.status(200).end(JSON.stringify({ message:'Send Mail' }))
}