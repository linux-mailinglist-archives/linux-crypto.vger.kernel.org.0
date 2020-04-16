Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388771AB7D1
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407702AbgDPGQd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:16:33 -0400
Received: from sonic310-23.consmr.mail.ne1.yahoo.com ([66.163.186.204]:38450
        "EHLO sonic310-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407554AbgDPGQ1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587017786; bh=85FejEn00gIkX4TgTiJo2MrF+4KusxIBycp5MFD4a0Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=brrNvmfgEOq5UpsF34zaEcnxb2lV4871RpPAhIqZYtLfiU343RgzOyJwd3cEqJvQoG+POEpiuJ3of3kuks19wim0WTiJMx+UceJeGJf88+2jO1wyC8KQJSNR0zxFJhcNJcjuFYDVOOVCd0DTMPErgvabGbkRZTzGPmxBKpG95pYk6bCkhXovs0bPGS7rVSmaGrvRVNcj86RAcOS/b3rwoJUz5itIyXYeV4bVPmRgvCHjMwEzg9PqMsam8hswhXQWJvt/oMIJpGpydCrPNXiGx2kA+pve63AeD0K4cR21BNY4CjUi8yCNduJT39XiEj5PN2WImc/BcO6bww5MO/YdjA==
X-YMail-OSG: ybE63dkVM1m3pvx_W2oqAH6kcNRAqNMUl.i5j.kLviQjyXWnaHCHV0wUbVHWH4.
 ulraAs3fkRhOh23dfwtKLKkhDMWvv_AmYYznTfd3haCQG9uxuTGaMhmoHnoP7r0qswAkkmrI6dLd
 iusUsggWHnd0iZdN3sNr1zdatio6InIrvk4pzU81xAIlvBeIhHLXh69eWv6Fo0YL6jufqBrgtUVV
 fXiV5vGORaH8c9h0KGvZHJn_kiGHLSJGeh5jnogYcuHTRT9fqCIdXkkfxi9_UfTUaqWyNiHTsDz_
 QjqrK3noVazPa_vkfg4HGfF4gpY_Td1pR56CafXdqUUe9A3PjnKMVlw.mcKy8dU7LC7J8PuC4Mu9
 w3DGMWxyaTCk4UNl.eIqwgGrkB8zRZoLWu4jweGFd0NihqFuNvFrdlYrzqbD_XbN.4PO18VKu3t9
 kRuNxdfB_P888UXllvuI2BqoeF8QUJI6M0eEEOB3x9D9.7voFFdCySBDRO6dULPG9OR7yBIoFv.E
 n7uw1Te7O0XG9S7CpTfglVApDkhjoEKKusKM925Vpgtx8KfO0.jTI3_Z5fdV3nrA9nr0AjhA3m2N
 6.s7CgSPnv5n9wQD5aYle3.5nwccOcvpCni8Z_1E4yo9P6P6q0CwoAXDtXhlWky4P0BpeUVDyuTm
 7WRJgj2tkXElW4iWVV.kuY.P14i0.9FhgtfIG1bQajWe7dSYU8wZ.D.qykFMfW9jgPhY8IrwZ_qx
 RI3yzP16BLT5nh7P7dFQTCt0Z9Hpu7QOFJYIyQ__BRVrfb4kdyOZApDJ706ttRG_2Eb0rhcr_FYv
 Fbit8oe2C7YXlc8dIy8c82iB7uflljMfzj8IBMDtspuyix8oYx4DfT8xFu0lEA4AsTWC57aAeoEy
 KVnzThWlIKaR_I2MIYe7tIov3YlAzOpvrqpWLqQy4bHLEoZuwl2GvFCZ57sgLnElrJfQcq5caP0q
 J0T6cdH1siPp1hfH6_GMfNsiWS2gFW6v3V6okBeglWhqyUUQJKi1_bxCu8J4e7PKpP_YV7UPEbkH
 IEThgOMfV4xRoJf6Ubo1C7py9WnvfvVlKBnXJ90TdnU_thOqNLQk8ropP3UYqxmrtyJ49XGuz5rr
 plz85_dpLg26q9looA4uPXtmYyzXoHrExr0NbShJVGAX5zKkWoO.BGP4iusGQViWuQed_pP52hWf
 tIpZ2PT9pESOxWZ4mfL0.xkk5wq3ddt29RDimsxv5Kwa6maN9EYo6uiv7hcNTci47RESEdhfI2Gx
 XS8BIxUJrxHM.1LOBpLCgdKXuU2jRmVZJUYclAwU1U8fi2jUYk2RY0M5mW_DdpBb5K.0Mjt_iAIE
 m7tyD8jJPSdW8V3FZ0ups3SabzQgyxRndcfbaZAtiF6fs5nF51izhCw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Apr 2020 06:16:26 +0000
Date:   Thu, 16 Apr 2020 06:16:22 +0000 (UTC)
From:   Lisa Mikerriding <lisamikerriding8@gmail.com>
Reply-To: lisamikerriding8@gmail.com
Message-ID: <397324635.1389451.1587017782732@mail.yahoo.com>
Subject: DEAR: FRIEND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <397324635.1389451.1587017782732.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



DEAR: FRIEND.

My name is Lisa Mikerriding I am sending this brief letter to solicit your support and partnership to transfer $10.5 million US Dollars. This money belongs to my late father Mike Riddering, my father and my mother were among those that were killed on 2016 terrorist attack at Splendid Hotel Ouagadougou Burkina Faso, my mother did not die instantly but she later gave up at the hospital.

we are from USA but reside in Burkina Faso, my father is an American missionary, before my father died with my mother at Splendid hotel,

Check out the web; (https://www.bbc.com/news/world-africa-35332792) for more understanding, I shall send you more information and the bank details when I receive positive response from you to follow up.
Contact me through this my private e-mail
 lisamikerriding8@gmail.com

Thanks

Ms.Lisa Mikerriding
