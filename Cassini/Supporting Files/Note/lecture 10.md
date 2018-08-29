#  Lecture 10. Multithreading and Autolayout

* Reference : https://youtu.be/kl2bDYiSgoc

## Multithreading 

### Queues
Multitherading is mostly about "queues" in iOS.
Function (usually closures) are simply lined up in a queue (like at the movies!).
Then those functions are pulled off the queue and executed on an associated thread(s)
Queues can be "serial" (one closure a time) or "concurrent" (multiple threads servicing it!). 

### Main Queue
There is a very special serial queue called the "main queue".
All UI activity MUST occur on this queue and this queue only.
Any, coversely, non-UI activity that is at all time consuming must NOT occur on that queue.
We do this because we want our UI to be highly responsive!
And also because we want things that happen in the UI to happen predictably (Serially).
Functions are pullded off and worked on in the main queue only when it is "quiet".

### Global Queues
For non-main-queue work, you're usually going to use a shared, global, concurrent queue.

### Getting a queue
Getting the main queue (where all UI activity must occur).

let mainQueue = DispatchQueue.main

### Putting a block of code on the queue

Multithreading is simply the process of putting closures into these queues.
There are two primay ways of putting a closure onto a queue.

You can just plop a closure onto a queue and keep running on the current queue.
queue.async {  ... }

or you can block the current queue waiting util the closure finishes on that other queue...

queue.sync {  ... }

We almost alwyas do the former.

### Getting a non-global queue

Very rarely you might need a queue other than main or global.
Your own serial queue (use this only if you have multiple, serially dependent activities)
let serialQueue = DispatchQueue(label: "MySerialQ")

Your own concurrent queue (rare that you would do this versus global queues) ...
let concurrentQueue = DispatchQueue(label: "MyConcurrentQ', attributes: .concurrent)

* Multithreaded iOS API
Quite a few places in iOS will do what they do off the main queue
They might even afford you the opportunity to do something off the main queue
iOS might ask you for a function (a closure, usually ) that executes of the main thread
Don't forget that if you want to do UI stuff there, you must dispatch back to the main queue!

* Example of a multithreaded iOS API

This API lets you fetch the contents of an http URL into a Data off the main queue!
let session = URLSession(configuration: .default)
if let url = URL(string: "http://stanford...") {
    let task = session.dataTask(with: url) { (data: Data?, response, error) in 
        // I want to do UI things here
        // with the data of the download
        // can I?
    }
    task.resume()
}

No. That's because that code will be run off the main queue.
How do we deal with this?
One way to use a variant of this API that lets you specify the queue to run on (main queue).
Here's another way using GCD...

This API lets you fetch the contents of an http URL into a Data off the main queue!
let session = URLSession(configuration: .default)
if let url = URL(string: "http://stanford...") {
    let task = session.dataTask(with: url) { (data: Data?, response, error) in 
        DispatchQueue.main.async {
        //do UI stuff here
        }
    }
    task.resume()
}

Now we can legally do UI stuff in there.
That's because the UI code you want to do has been dispatched back to the main queue.


