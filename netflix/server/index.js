//import from packages
///console.log("hello")
const express =require('express');
const mongoose =require('mongoose');
//import fron other files
const  authRouter=require("./routes/auth");
const PORT=3000;
var bodyParser = require('body-parser');
 
const app=express();
 

const DB ='mongodb+srv://ashwanichandel0001:Ashwani123@cluster0.rg70ig1.mongodb.net/?retryWrites=true&w=majority';

//middleware

app.use(express.json());
app.use(bodyParser.json())
app.use(authRouter);

 
 
 

//connections
mongoose.connect(DB).then(()=>{
    console.log("connection successful");
}).catch((e)=>{
    console.log(e);
});


app.listen(PORT,  ()=> {
  console.log('connect at port'+ PORT)
});
app.get('/', (req, res) => {
  res.send("lowdu")
})