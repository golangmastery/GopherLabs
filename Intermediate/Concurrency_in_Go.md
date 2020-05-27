
# What is concurrency ?

- “Concurrency is about dealing with lots of things at once. Parallelism is about doing lots of things at once” 

Large   programs   are   often   made   up   of   many   smaller sub-programs. 
For   example  a   web  server   handles  re-quests made from web browsers and serves up HTM Lweb pages in response. 
Each request is handled like asmall program.It would be ideal for programs like these to be able torun their smaller 
components at the same time (in the case   of   the   web   server   to   handle   multiple   requests).
Making   progress   on   more   than   one   task   simultane-ously is known as concurrency. 
Go has rich support forconcurrency using goroutines and channels


- Goroutines : A  goroutine   is   a   function   that   is   capable   of   running concurrently   with   other   functions.   To  create  a   goroutine we use the keyword go followed by a function invo-cation
