Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745EA2B2BF8
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Nov 2020 08:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKNHcN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 14 Nov 2020 02:32:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7898 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKNHcN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 14 Nov 2020 02:32:13 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CY6V074PHz74cs;
        Sat, 14 Nov 2020 15:31:52 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 14 Nov 2020
 15:31:57 +0800
Subject: Re: [PATCH 0/1] arm64: Accelerate Adler32 using arm64 SVE
 instructions.
To:     Dave Martin <Dave.Martin@arm.com>
CC:     <alexandre.torgue@st.com>, <catalin.marinas@arm.com>,
        <gaoguijin@huawei.com>, <colordev.jiang@huawei.com>,
        <luchunhua@huawei.com>, <linux-crypto@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <liliang889@huawei.com>,
        <will@kernel.org>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <herbert@gondor.apana.org.au>
References: <20201103121506.1533-1-liqiang64@huawei.com>
 <20201105165301.GH6882@arm.com>
 <f323de50-c358-88e7-6588-7d14542f2754@huawei.com>
 <20201110104629.GJ6882@arm.com>
 <89a9bdcc-b96e-2f2d-6c52-ca44e0e3472c@huawei.com>
 <20201110160708.GL6882@arm.com>
 <484ad2c8-3905-fc98-237c-f7eb4045edbc@huawei.com>
 <20201112111745.GS6882@arm.com>
From:   Li Qiang <liqiang64@huawei.com>
Message-ID: <72514954-ea04-6aa3-73d8-bb0fc39b6de2@huawei.com>
Date:   Sat, 14 Nov 2020 15:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112111745.GS6882@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.110.54.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



在 2020/11/12 19:17, Dave Martin 写道:
> On Thu, Nov 12, 2020 at 03:20:53PM +0800, Li Qiang wrote:
>>
>>
>> 在 2020/11/11 0:07, Dave Martin 写道:
>>>>>>> 	add     zA.s, pP/m, zA.s, zX.s        // zA.s += zX.s
>>>>>>>
>>>>>>> 	msb     zX.s, pP/m, zJ.s, zB.s        // zX.s := zB.s - zX.s * zJ.s
>>>>>>>
>>>>>>> 	movprfx zB, zA
>>>>>>> 	mad     zB.s, pP/m, zV.s, zX.s        // zB.s := zX.s + zA.s * V
>>>> I found the bug I encountered earlier, that is, the calculation of zB here
>>>> needs to use pA with all elements activated. The reason is the same as my
>>>> previous guess, because all elements of zA should be involved when calculating zB.
>>>> Because the original calculation formula is like this.
>>>>
>>>> For example:
>>>> In the last loop:
>>>> 	left byte is:	  3 |   4 |  \0 |
>>>> 	zA.s is:	100 | 200 | 100 | 200 (sum = 600)
>>>> 	pP.s is:	  1 |   1 |   0 |   0 (Only activate the first 2 channels)
>>>>
>>>> At this time, if the calculation of zB only takes the first 2 active elements, the data
>>>> is incomplete, because according to the description of the original algorithm, zB is always
>>>> based on the sum of all the accumulated bytes.
>>> Yes, you're quite right here: zX is partial: only the elements pP are
>>> valid; but all elements of zA and zB are always valid.  I was focusing
>>> too much on the handling of the partial input block.
>>>
>>>> Here we can simply change the prediction register used in the two sentences related to
>>>> zB to the one that is all true (it is pA in our code), like this:
>>>> 	msb     zX.s, pA/m, zJ.s, zB.s        // zX.s := zB.s - zX.s * zJ.s
>>> Are you sure about this?  In a final partial block, the trailing
>>> elements of zX.s beyond pP will be leftover junk from the last
>>> iteration.
>>
>> Yes, I have verified this code and it is correct. The reason is that if pP is used here,
>> the inactive elements of zB will be ignored in zX, which will cause data loss.(I think it is
> 
> Yes, you're quite right.  I was forgetting about the /z (zeroing)
> semantics for the ld1b.  This means that we get away with not
> inactivating those elements in the msb instruction, since zeros
> multiplied by the elements of zJ remain zero.
> 
>> because the zB data is covered by the multiplication and addition results of zX, zA, and zV
>> using movprfx and mad. Have I got that right?) :)
> 
> Yes, I think so.
> 
>> On the other hand zX uses the prediction register pP/z when loading data, the value of the
>> inactive element is 0, the inactive element in zX will not affect the final result, the inactive
>> element in zB will be directly assigned to the inactive element of zX element.
>>
>> Then in the next instruction, it will be added to zB along with zX.
> 
> Yes.
> 
> This might be part of the reason why the architects decided that SVE
> loads zero the inactive elements instead of leaving them unchanged.

I think so, it is a useful feature in this scenario.

> 
>>
>>>
>>> This might require a bit more thought in order to get the final block
>>> handling correct.
>>>
>>>> trailloop:			// Last cycle entrance
>>>>         cntp    x6, p1, p0.s	// Get active element count of last cycle
>>>>         cpy     zV.s, p1/m, w6	// Set zV to the actual value.
>>> Note that you can also write "mov" here, but I'm not sure which alias is
>>> preferred>
>>>> loop:				// Core loop entrance
>>>>         ld1b    zX.s, p0/z, [x1]
>>>>         incw    x1
>>>>
>>>>         add     zA.s, p0/m, zA.s, zX.s	// The calculation of zA still needs to use p0
>>>>         msb     zX.s, p1/m, zJ.s, zB.s	// Change p register here
>>>>         movprfx zB, zA
>>>>         mad     zB.s, p1/m, zV.s, zX.s	// Change p register here
>>> As discussed above, are you sure this is correct now?
> 
> I think we've agreed that it is correct.
> 
> Thinking about the code flow, I think the initialisation of zV is
> slightly wrong: for very short data, the first block may be shorter than
> VL.
> 
> I think this is easily solved by getting rid of the constant
> initialisation for zV and removing the branch that skips the CNTP code
> when entering the loop for the first time.  That way, zV gets
> initialised to the correct thing on entering the loop, irrespective of
> whether we have a whole vector on the first iteration.

The problem you are worried about is valuable. This problem must be considered when
the loop is unrolled. However, the code in my email a few days ago did not have this
problem, and I have also tested use cases with a length less than VL. :)

The reason is that when the length of the test case is less than VL, 'b.last' is
false and 'b.first' is true, and then it will still jump directly to trailloop to update zV.

	b	start
trailloop:
	cntp	x6, p1, p0.s
	mov	zV.s, p1/m, w6
loop:
	...
start:
	whilelo	p0.s, x1, xLimit
	b.last	loop
	b.first	trailloop

> 
> Note, to squeeze maximum performance out of this, you still probably
> want to unroll the loop a few times so that you can schedule useful work
> in between each load and the computations that depend on it.

Yes, I tried to expand the loop on the basis of the previous code, but the effect was
not very satisfactory(the performance is only about 2 times that of the C version),
so I reconsidered the way of implementation, based on the formula you derived earlier.

> 
>>>> start:
>>>>         whilelo p0.s, x1, xLimit
>>>>         b.last  loop		// The condition for the core loop to continue is that b.last is true
>>>>         b.first trailloop	// If b.last is false and b.first is true, it means the last cycle
>>>>
>>>>         uaddv   d0, p1, zA.s
>>>>         uaddv   d1, p1, zB.s
>>>>
>>>>         mov     x12, v0.2d[0]
>>>>         mov     x13, v1.2d[0]
>>> The "2" here seems not to be required by the syntax, although it's
>>> harmless.
>>
>> Yes I deleted it.
>>
>>>
>>>>         add     x10, x10, x12
>>>>         add     x11, x11, x13
>>>>         add     x11, x11, x2
>>> If x10 and x11 are used as accmulators by the caller, I guess this works.
>>
>> X10 and X11 are part A and part B of the initial value of adler32 passed in by the caller.
> 
> Right, that makes sense.
> 
>>
>>>
>>>>         mod65521        10, 14, 12
>>>>         mod65521        11, 14, 12
> 
> Note, can you replace these with udiv?
> 
> While using mul might be slightly cheaper to achieve this, it makes the
> code more complex and will have a negligible impact on the overall
> cost...
> 
> So, does something like this work:
> 
> 	mov	x3, #65521
> 	udiv	x4, x10, x3
> 	udiv	x5, x11, x3
> 	msub	x10, x4, x3, x10
> 	msub	x11, x5, x3, x11

Yes, the reason for doing this here is that I initially performed modulo division
in the loop body, so that we can never overflow the data, so I considered optimizing
the division to multiplication.If we only do a modular division at the end, we don't
need to implement the code like this.

> 
>>>>         lsl     x11, x11, #16
>>>>         orr     x0, x10, x11
>>>>         ret
>>>> -->8--
>>>>
>>>> After this modification, The test results are correct when the data length is less than about 8 Kbyte,
>>>> part A will still be correct after 8K, and an overflow error will occur in part B. This is because A
>>>> only accumulates all the bytes, and the accumulative acceleration of B expands faster, because the
>>>> accumulative formula of B is:
>>>> 	B = (1 + D1) + (1 + D1 + D2) + ... + (1 + D1 + D2 + ... + Dn) (mod 65521)
>>>>            = n×D1 + (n−1)×D2 + (n−2)×D3 + ... + Dn + n (mod 65521)
>>>>
>>>> If we take the average value of Dx to 128 and n to 8192:
>>>> 	B = (1 + 2 + ... + 8129) * 128 + 8192
>>>> 	  = 4,295,499,776 (32bit overflow)
>>>>
>>>> So I think the 32-bit accumulator is still not enough for part B here. :)
>>>>
>>>> -- 
>>>> Best regards,
>>>> Li Qiang
>>> That makes sense.  I hadn't tried to calculate the actual bound.
>>>
>>> It may be worth trying this with 64-bit accumulators.  This will
>>> probably slow things down, but it depends on the relative computation /
>>> memory throughput exhibited by the hardware.
>>
>> If a 64-bit wide vector register is used, for most scenes where the amount of data is not particularly large,
>> is it wasted more vector resources?
> 
> Yes :)
> 
> Depending on the algorithm, this might be a better tradeoff if it meant
> that the data could be processed in larger chunks.  I suspect that the
> tradeoff is unfavourable in this particluar case though -- but I haven't
> tried it.
> 
>> Maybe we can also try to use 16-bit wide vector registers to load data and calculations,
>> and accumulate them into the scalar register xn before overflow, just like my original patch,
>> but I can try to use ascending order to change the processing of the last loop Be more elegant.
> 
> Perhaps.  But I assumed that 16-bit elements would overflow much too
> fast to be practical.  Just multiplying zX by zJ once can produce
> element values up to 0xfe01 if VL is 256 bytes.
> 
> Did you have some idea for how to make this work?
> 
> It may be possible to do 16-bit multiplies with 32-bit accumulation.
> SVE2 has some NEON-style mixed-width multiply-accumulate instructions
> that can achieve this sort of thing directly, but in SVE(1) I think 
> you would have to break the multiply-accumulates up.  Say:
> 
> 	mul	zX.h, pP/m, zX.h, zJ.h
> 	sub	zX.s, pP/m, zB.s, zX.s
> 
> whilelo pP.s should generate a predicate with odd .h elements inactive,
> and ld1b zX.s, pP/z, ... will make sure those elements are all zeroed in
> xX.h.
> 
> I'm not sure this would be faster than a single 32-bit msb, since
> multiply-accumulates are likely to be heavily optimised in the hardware,
> but you could try it.

I adopted a part of the patch I originally submitted, combined with the formula you gave
to calculate B[n+v] using an increasing sequence, and then modify the code again. The code is at the end.

> 
>>>
>>> I think the code can't be bulletproof without breaking the input into
>>> chunks anyway, though.
>>
>> I don't quite understand what it means here. Does it mean that the input bytes are read into the vector in
>> blocks for calculation (this is how it is done now) or the intermediate results are stored in different elements
>> of the vector in blocks during the calculation process? :-)
> 
> I mean, you limit the number of iterations of the core loop so that
> overflow doesn't happen.  You're already doing this; I just wanted to
>  make the point that 64-bit accumulators probably don't solve this
> problem, even though it will take a very large number of iterations to
> cause an overflow.
> 
> Unless Adler32 specifies the maximum length of the input data not to
> exceed some value, it could go on forever -- so overflow becomes
> inevitable.

Yes, I understand that if we do not perform the modulo division in time, data overflow will happen sooner or later.
So my initial patch added modulo division to the loop body and optimized it.:)

As you said, if we don’t want to perform modular division in the loop body, then we need to block the input and
perform the modular division in time before the data will never overflow (Need to consider the worst case,
that is, all data is 0xff).

--8<--
	...
	adler_A .req    x10
	adler_B .req    x11
	
	.macro	adler32_core
	ld1b	zX.h, p0/z, [x1]	// load bytes
	inch	x1

	uaddv	d0, p0, zX.h
	mul	zX.h, p0/m, zX.h, zJ.h	// Sum [j=0 .. v-1] j*X[j+n]
	mov	x9, v0.d[0]
	uaddv	d1, p0, zX.h
	add	adler_A, adler_A, x9	// A[n+v] = An + Sum [j=0 ... v-1] X[j]
	mov	x9, v1.d[0]
	madd	adler_B, x7, adler_A, adler_B	// Bn + v*A[n+v]
	sub	adler_B, adler_B, x9		// B[n+v] = Bn + v*A[n+v] - Sum [j=0 .. v-1] j*X[j+n]
	.endm

	.macro	adler32_loop
	whilelo	p0.h, x1, xLimit
	cntp	x7, p0, p0.h		// x7 is used to store 'v'
	adler32_core
	.endm

ENTRY(XXX)
	...
	add	xLimit, x1, x2

loop:
	adler32_loop
	adler32_loop
	adler32_loop
	adler32_loop
	cmp	x7, #0
	b.ne	loop

	mov	x3, #65521
	udiv	x4, x10, x3
	udiv	x5, x11, x3
	msub	x10, x4, x3, x10
	msub	x11, x5, x3, x11
	...
-->8--


I tested 500Mbyte random data, the result is completely correct, longer data volume did not test,
I think we can also wrap a layer of data block control code, that is, after the data volume
exceeds a certain threshold, the control code The input data is segmented by threshold, and
the initial adler32 of the subsequent segment is the result of the previous segment calculation.

Like:
	adler32 = 1;
	if (len <= MAX_BLOCK_LEN)
		adler32 = adler32_sve(adler32, buf, len);
	else {
		int i = 0;
		while (i < len) {
			int block_len = (len - i > MAX_BLOCK_LEN) ? MAX_BLOCK_LEN : (len - i);
			adler32 = adler32_sve(adler32, &buf[i], block_len);
			i += block_len;
		}
	}
	return adler32;

In this way, we don't have to worry about when the data overflows and when to modulo in the core algorithm code.

-- 
Best regards,
Li Qiang
