import asyncio

# An asynchronous function (coroutine) that simulates a task
async def say_hello():
    print("Hello!")
    await asyncio.sleep(2)  # Simulating a 2-second delay
    print("Goodbye!")

# Another asynchronous function that simulates a task
async def say_world():
    print("World!")
    await asyncio.sleep(1)  # Simulating a 1-second delay
    print("End of World!")

# The main asynchronous function that will run both tasks concurrently
async def main():
    # Run both say_hello and say_world concurrently using asyncio.gather
    await asyncio.gather(say_hello(), say_world())

# Run the main coroutine using asyncio.run()
asyncio.run(main())
