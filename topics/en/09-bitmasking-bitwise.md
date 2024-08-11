# Bitmasking & Bitwise
**Bitmasking** and **Bitwise** are concepts used mainly in programming to manipulate and represent data and objects at the bit level, allowing efficient operations.

**Bitmasking** refers to the process of using a bit mask to manipulate or check the value of specific bits in a binary number.

This is done using **bitwise** operators, such as AND (`&`), OR (`|`), XOR (`^`), NOT (`~`), among others. Bitmasks are used to define which bits of a number will be modified, tested, or enabled.

## What is it for?

- **Permissions and States:** Can be used to represent and manipulate permissions or states in a system. For example, in a permissions system, each bit may represent an access level.

- **Compress Data and Information:** In some situations, it is possible to compress several pieces of information into a single field using bitmasking.

- **Optimization:** Using bitmasking can be more time and space efficient by saving fields in the table.

## Brief summary of bits, bytes and bases
The most basic level of representation of anything in a computer is a bit.

A bit is just a value, which can be `0` or `1`. We call it Nibble when we have four bits `0000` or `1111`. A byte is made up of 8 bits: `0000 0000` or `1111 1111`.

We also have Word, which is 16 bits: `0000 0000 0000 0000` or `1111 1111 1111 1111`.

**What does it all mean?**

If the Bit with the value `1` is on and with the value `0` it is off. So, in one Byte we have 8 value options.

**These values ​​can be: fields, objects, validations, process cycle and much more.**

The best part is that it has no end, you can enable as many bits as you need.

So that we can work with **Bitwise** operations, we do the **conversion from Base 02 to Base 10, or better yet, from binary (Base 02) to decimal (Base 10).**

The best and most practical way to work with this is to **map the bit values.**

Below is a table **example of conversions:**

- ![all_bits](/topics/imgs/09-bitmask/all_bits_on.png)

## How to Use Bitwise in SQL?
The first step is to define which values ​​each bit is related to.

I will take into consideration a fact table related to an e-commerce.

**Order lifecycle:**
```
Attribute                  Value
--------------------------------------
Order Placed                 1
Payment in Processing        2
Identified Payment           4
Fast Delivery                8
Order Sent for Delivery      16
Order Delivered              32
Customer Feedback            64
Order Canceled               128
```

This is an example of what some examples would look like using **Bitwise** to add the values:
```
-- Order Placed
 SELECT 1 | 1 -- (1)

-- Payment in Process
 SELECT 1 | 2 -- (3)

-- Identified Payment
 SELECT 1 | 2 | 4 -- (7)

-- Has the order been shipped yet?
 SELECT 1 | 2 | 16 -- (19)

-- How about fast delivery?
 SELECT 1 | 2 | 8 | 16 -- (27)

-- Does the customer want to cancel the fast delivery option?
 SELECT 27 & ~8 -- (19)

 -- Before removing, is the Quick Delivery option enabled?
 DECLARE @status INT = 27;

-- Check if bit 8 is on (returns 1 if on, 0 if off)
SELECT CASE WHEN (@status & 8) > 0 THEN 1 ELSE 0 END AS Bit8IsOn;
```

**What are we doing here?** Basically turning bits off and on.

**And where do these other numbers come from?** Well, this table will explain it better.

- ![values_tables](/topics/imgs/09-bitmask/values_tables.png)
- https://terminaldeinformacao.com/2013/01/18/conversao-de-bases/

If you notice in the Payment in processing option, we have activated the initial two bits `0011`, so it returns a `3`.

And this is what we call **Bitmasking** with **Bitwise** manipulation in SQL.