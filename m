Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29E43E29E9
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Aug 2021 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbhHFLlo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Aug 2021 07:41:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51748 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242420AbhHFLln (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Aug 2021 07:41:43 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mByE4-0002eZ-I7; Fri, 06 Aug 2021 19:41:20 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mByDi-0003cs-CN; Fri, 06 Aug 2021 19:40:58 +0800
Date:   Fri, 6 Aug 2021 19:40:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: Re: [REPORT] Request for reviewing crypto code wrt
 wait_for_completion()
Message-ID: <20210806114058.GA13896@gondor.apana.org.au>
References: <20210803021611.GA28236@X58A-UD3R>
 <20210806080344.GA5788@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806080344.GA5788@X58A-UD3R>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 06, 2021 at 05:03:44PM +0900, Byungchul Park wrote:
> Hello crypto folks,
> 
> I developed a tool for tracking waiters and reporting if any of the
> events that the waiters are waiting for would never happen, say, a
> deadlock. Yes, it would look like Lockdep but more inclusive.
> 
> While I ran the tool(Dept: Dependency Tracker) on v5.4.96, I got some
> reports from the tool. One of them is related to crypto subsystem.
> Because I'm not that familiar with the code, I'd like to ask you guys to
> review the related code.
> 
> If I understand correctly, it doesn't actually cause deadlock but looks
> like a problematic code. I know you are not used to the format of the
> report from Dept so.. let me summerize the result.
> 
> The simplified call trace looks like when the problem araised :
> 
> THREAD A
> --------
> A1 crypto_alg_mod_lookup()
> A2    crypto_probing_notify(CRYPTO_MSG_ALG_REQUEST)
> A3       cryptomgr_schedule_probe()
> A4          kthread_run(cyptomgr_probe) ---> Start THREAD B
> 
> A5    crypto_larval_wait()
> A6       wait_for_completion_killable_timeout(c) /* waiting for B10 */

This larval would be an instantiation larval, and it can only be
woken up by thread B, not C.

> THREAD B
> --------
> B1 cryptomgr_probe()
> B2    pkcslpad_create()
> B3       crypto_wait_for_test()
> B4          crypto_probing_notify(CRYPTO_MSG_ALG_REGISTER)
> B5             cryptomgr_schedule_test()
> B6                kthread_run(cyptomgr_test) ---> Start THREAD C
> 
> B7    tmpl->alloc()
> B8    crupto_register_instance()
> B9          wait_for_completion_killable(c) /* waiting for C3 */
> B10   complete_all(c)

I presume you're talking about about the wait_for_completion from
crypto_wait_for_test, in which case it can only be woken by thread
C.  After which thread B will return to cryptomgr_probe and wake up
thread A.

> THREAD C
> --------
> C1 cryptomgr_test()
> C2    crypto_alg_tested()
> C3       complete_all(c)
> 
> ---
> 
> For example, in this situation, I think C3 could wake up both A6 and B9
> before THREAD B reaches B10 which is not desired by A6. Say, is it okay
> to wake up A6 with B7 ~ B9 having yet to complete?

AFAICS thread C only wakes up test larvals, not instantiation larvals.
Please let me know if you have any further issues.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
