/* AUTHOR: MATTHEW AQUILES
** WALLETLESS LLC
** DATE LAST EDITED: 3/19/2017
** NOTES: MODEL CREATED TO DEFINE FUNCTIONS TO QUERY MESSAGES TABLE IN walletlessDB
** TODO: define models for use in route definitions
*/

var db = require('../dbconn'); //reference to dbconn.js file

var messages = {
  //function to add a new message to the message table
  addMessage:function(Message, callback){
    return db.query("insert into messages values(?,?,?,?,?,?,?)", [
      Message.message_id,
      Message.sender_id,
      Message.receiver_id,
      Message.subject,
      Message.body,
      Message.creat_date,
      Message.is_read], callback);
  },
  //select * from messages table by either message sender or receiver
  getMsgBySndr:function(id, callback){
    return db.query("select * from messages where sender_id=?", [id], callback);
  },
  getMsgByRcvr:function(id, callback){
    return db.query("select * from messages where receiver_id=?", [id], callback);
  },

  //update the is_read column of the messages table once the message is read
  updateIsRead:function(id, Message, callback){
    return db.query("update messages set is_read=? where message_id=?", [Message.is_read, id], callback);
  },

  //delete message from the database
  //not really so sure about this one cause if both/all parties dont delete the message we dont want to delete it from the db table
  //just gonna write the function to delete it anyway
  deleteMessage:function(id, callback){
    return db.query("delete from messages where message_id=?", [id], callback);
  }
}

module.exports = messages; //export function definitions for use in route definitions