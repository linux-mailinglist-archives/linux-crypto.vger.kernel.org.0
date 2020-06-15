Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA271F9E41
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgFOROx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 13:14:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:16574 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgFOROx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 13:14:53 -0400
IronPort-SDR: stWnO0CeM5z61j9X8GOLhtCtFD91mYqB+cMk+gY2rcYhL8HHrMc9QxGoiKco/X2rdanTf2Pvyu
 +2xidEoqxDEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 10:14:52 -0700
IronPort-SDR: fNW3/ouO37kjjqkWXJCp8LdVCrVW2sPfqqy1rCKVv9UQ1jSw6YxSeXCor/1RN9U75g010v1MpG
 FZZZqwi02gPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="476106548"
Received: from unknown (HELO intel.com) ([10.223.74.178])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2020 10:14:51 -0700
Date:   Mon, 15 Jun 2020 22:34:14 +0530
From:   Anshuman Gupta <anshuman.gupta@intel.com>
To:     linux-crypto@vger.kernel.org
Cc:     anshuman.gupta@intel.com
Subject: [Query] RSA SHA-384 signature verification
Message-ID: <20200615170413.GF14085@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi ,
I wanted to verify a RSA SHA-384 signature.
I am using crypto_alloc_shash(), crypto_shash_digest() API to extract
the SHA-384 digest.
I am having public key along with the sha-384 digest extracted from raw data and signature.  
AFAIU understand from crypto documentation that i need to verify the
signature by importing public key to akcipher/skcipher API.
Here i am not sure which cipher API to prefer symmetric key cipher or asymmetric key
cipher API.

There are two types of API to import the key.
crypto_skcipher_setkey()
crypto_akcipher_set_pub_key()

Also i am not sure exactly which algo to use for RSA-SHA384 signature
verification.

Any help or inputs from crypto community will highly appreciated.

Thanks ,
Anshuman Gupta.

