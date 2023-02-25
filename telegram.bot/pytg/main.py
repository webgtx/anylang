import logging
import os
from telebot import TeleBot, custom_filters
from telebot.types import InlineKeyboardMarkup, InlineKeyboardButton
from telebot.handler_backends import State, StatesGroup
from telebot.storage import StateMemoryStorage

bot = TeleBot(os.getenv("TOKEN"), state_storage=StateMemoryStorage())

class UserStates(StatesGroup):
    name = State()
    age = State()

def init_markup():
    markup = InlineKeyboardMarkup()
    markup.row_width = 2
    markup.add(
        InlineKeyboardButton("Python", callback_data="cb_python"),
        InlineKeyboardButton("Lua", callback_data="cb_lua"),
        InlineKeyboardButton("Type", callback_data="cb_type")
        )
    return markup

@bot.callback_query_handler(func=lambda call:True)
def callbacl_query(call):
    if call.data == "cb_python":
        bot.answer_callback_query(call.id, "Lua butter then Python")
        bot.send_message(call.from_user.id, "understood?")
    elif call.data == "cb_lua":
        bot.answer_callback_query(call.id, "Thats right")
        print()
    elif call.data == "cb_type":
        bot.set_state(call.from_user.id, UserStates.name)
        bot.send_message(call.from_user.id, "Write your name")

@bot.message_handler(commands=["help", "start"])
def welcome(msg):
    bot.reply_to(msg, "Hello there")
    bot.send_message(msg.chat.id, "Who is faster? Lua or Python?", reply_markup=init_markup())

@bot.message_handler(state=UserStates.name)
def ask_age(msg):
    bot.send_message(msg.chat.id, "Your age?")
    bot.set_state(msg.from_user.id, UserStates.age, msg.chat.id)

@bot.message_handler(state=UserStates.age)
def result(msg):
    with bot.retrieve_data(msg.from_user.id, msg.chat.id) as data:
        msg = ("Ready, take a look:\n"
        f"Name: {data['name']}\n"
        f"Age: {msg.text}")
        bot.send_message(msg.chat.id, msg, parse_mode="html")
    bot.delete_state(msg.user_from.id, msg.chat.id)

bot.infinity_polling()
