Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17CC517701
	for <lists+linux-crypto@lfdr.de>; Mon,  2 May 2022 20:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386982AbiEBTAj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 May 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiEBTAi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 May 2022 15:00:38 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A7B64D8;
        Mon,  2 May 2022 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651517829; x=1683053829;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EaA43+lq703oqOaiKMUFVMTMGLQEfIcFBomnlHp/XXQ=;
  b=iJGQT0ceECmhZvFWEiKWrCMA8Svf17x70qkfwL85V1LNGEqK5zAJM28E
   OhN7jBezwGJ54M4aHR36uPHhi38LdJoLl1MhSef3QUKP1DeWxduZXuc1I
   MgMr+i0Qlj363VQhwtqaJtgnP8MG4qoSXGLXDksbYBzogXxW08jS+O2Zk
   M=;
X-IronPort-AV: E=Sophos;i="5.91,193,1647302400"; 
   d="scan'208";a="192263801"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 02 May 2022 18:57:07 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com (Postfix) with ESMTPS id 99D8E41529;
        Mon,  2 May 2022 18:57:06 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 2 May 2022 18:57:06 +0000
Received: from [0.0.0.0] (10.43.160.180) by EX13D20UWC001.ant.amazon.com
 (10.43.162.244) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 18:57:03 +0000
Message-ID: <f90d5e06-8cd7-14b3-43d5-c4799597d023@amazon.com>
Date:   Mon, 2 May 2022 20:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Lennart Poettering <mzxreary@0pointer.de>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Colm MacCarthaigh" <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com> <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com> <YnAMBzhcJhGR5XOK@gardel-login>
 <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
 <YnAiylnSytuYM53z@zx2c4.com>
From:   Alexander Graf <graf@amazon.com>
In-Reply-To: <YnAiylnSytuYM53z@zx2c4.com>
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D16UWC004.ant.amazon.com (10.43.162.72) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

SGV5IEphc29uLAoKT24gMDIuMDUuMjIgMjA6MjksIEphc29uIEEuIERvbmVuZmVsZCB3cm90ZToK
PiBIaSBBbGV4LAo+Cj4gT24gTW9uLCBNYXkgMDIsIDIwMjIgYXQgMDc6NTk6MDhQTSArMDIwMCwg
QWxleGFuZGVyIEdyYWYgd3JvdGU6Cj4+IHRvIGNvbGxlY3QgdGhlIHVzZSBjYXNlcyB3ZSBhbGwg
aGF2ZSBhbmQgZXZhbHVhdGUgd2hldGhlciB0aGlzIHBhdGNoIGlzCj4+IGEgZ29vZCBzdGVwcGlu
ZyBzdG9uZSB0b3dhcmRzIHRoZSBmaW5hbCBzb2x1dGlvbi4KPiBJbmRlZWQsIEknbSBhbGwgZm9y
IGNvbGxlY3RpbmcgdXNlIGNhc2VzLiBXaGF0IEkgbWVhbnQgdG8gc2F5IGlzIHRoYXQKPiB3ZSdy
ZSBub3QgZ29pbmcgdG8gYWRkIHNvbWV0aGluZyAianVzdCAnY3V6IjsgSSdkIGxpa2UgdG8gaGF2
ZSBzb21lCj4gY29uY3JldGUgdGhpbmdzIGluIG1pbmQuCj4KPiBUbyBkYXRlLCBJJ3ZlIGJhc2lj
YWxseSBoYWQgeW91ciBzMm4gY2FzZSBpbiBtaW5kLCBidXQgYXMgeW91IGhhdmVuJ3QKPiByZXNw
b25kZWQgdG8gdGhpcyBpbiB0aGUgbGFzdCBtb250aCwgSSBzdGFydGVkIGxvb2tpbmcgdG8gc2Vl
IGlmIHRoaXMKCgpVbmZvcnR1bmF0ZSB2YWNhdGlvbiB0aW1pbmcgb24gbXkgc2lkZSBJIHN1cHBv
c2UgOikKCgo+IHdhcyB1c2VmdWwgZWxzZXdoZXJlIG9yIGlmIEkgc2hvdWxkIGFiYW5kb24gaXQs
IHNvIEkgZmlsZWQgdGhpcyBpc3N1ZQo+IHdpdGggdGhlIEdvIHByb2plY3Q6IDxodHRwczovL2dp
dGh1Yi5jb20vZ29sYW5nL2dvL2lzc3Vlcy81MjU0ND4uIFdlJ3JlCj4gb3ZlciBoYWxmd2F5IHRo
cm91Z2ggNS4xOCBub3csIGFuZCBvbmx5IGF0IHRoaXMgcG9pbnQgaGF2ZSB5b3UgYXJyaXZlZAo+
IHRvIGRpc2N1c3MgYW5kIGZpbmFsaXplIHRoaW5ncy4gU28gaW4gYWxsIGxpa2VsaWhvb2Qgd2Un
bGwgd2luZCB1cAo+IHRhYmxpbmcgdGhpcyB1bnRpbCA1LjIwIG9yIG5ldmVyLCBzaW5jZSB3aGF0
IEkgdGhvdWdodCB3YXMgYW4gZWFzeQo+IGNvbnNlbnN1cyBiZWZvcmUgbm93IGFwcGFyZW50bHkg
aXMgbm90LgoKClNvIGZhciBJIHNlZSBsaXR0bGUgdGhhdCB3b3VsZCBibG9jayB5b3VyIHBhdGNo
PyBJdCBzZWVtcyB0byBnbyBpbnRvIGEgCmdvb2QgZGlyZWN0aW9uIGZyb20gYWxsIEkgY2FuIHRl
bGwuCgoKPj4gMSkgQSB3YXkgZm9yIGxpYnJhcmllcyBzdWNoIGFzIHMybiB0byBpZGVudGlmeSB0
aGF0IGEgY2xvbmUgb2NjdXJyZWQuCj4+IEJlY2F1c2UgaXQncyBhIGRlZXAtZG93biBsaWJyYXJ5
IHdpdGggbm8gYWNjZXNzIHRvIGl0cyBvd24gdGhyZWFkIG9yIHRoZQo+PiBtYWluIGxvb3AsIGl0
IGNhbiBub3QgcmVseSBvbiBwb2xsL3NlbGVjdC4gTW1hcCBvZiBhIGZpbGUgaG93ZXZlciB3b3Vs
ZAo+PiB3b3JrIGdyZWF0LCBhcyB5b3UgY2FuIGNyZWF0ZSB0cmFuc2FjdGlvbnMgb24gdG9wIG9m
IGEgNjRiaXQgbW1hcCdlZAo+PiB2YWx1ZSBmb3IgZXhhbXBsZS4KPiBJIGRpZG4ndCByZWFsaXpl
IHRoYXQgczJuIGNhbid0IHBvbGwuIFRoYXQncyBzdXJwcmlzaW5nLiBJbiB0aGUgd29yc3QKPiBj
YXNlLCBjYW4ndCB5b3UganVzdCBzcGF3biBhIHRocmVhZD8KCgpZb3UgYmxvY2sgdGhlIHRocmVh
ZCBvbiBwb2xsLCBzbyB0aGUgb25seSBvcHRpb24gaXMgYSB0aHJlYWQuIEkgd2FzIAp1bnRpbCBu
b3cgYWx3YXlzIHVuZGVyIHRoZSB3b3JraW5nIGFzc3VtcHRpb24gdGhhdCB3ZSBjYW4ndCBkbyB0
aGlzIGluIGEgCnRocmVhZCBiZWNhdXNlIHlvdSBkb24ndCB3YW50IHlvdXIgc2luZ2xlIHRocmVh
ZGVkIGFwcGxpY2F0aW9uIHRvIHR1cm4gCmludG8gYSBwdGhyZWFkZWQgb25lLCBidXQgeW91IG1h
a2UgbWUgd29uZGVyLiBMZXQgbWUgY2hlY2sgd2l0aCBUb3JiZW4gCnRvbW9ycm93LgoKCj4KPj4g
MikgQSB3YXkgdG8gbm90aWZ5IGxhcmdlciBhcHBsaWNhdGlvbnMgKHRoaW5rIEphdmEgaGVyZSkg
dGhhdCBhIHN5c3RlbQo+PiBpcyBnb2luZyB0byBiZSBzdXNwZW5kZWQgc29vbiBzbyBpdCBjYW4g
d2lwZSBQSUkgYmVmb3JlIGl0IGdldHMgY2xvbmVkCj4+IGZvciBleGFtcGxlLgo+IFN1c3BlbnNp
b24sIGxpa2UgUzMgcG93ZXIgbm90aWZpY2F0aW9uIHN0dWZmPyBUYWxrIHRvIFJhZmFlbCBhYm91
dCB0aGF0OwoKCldoZXRoZXIgeW91IGdvIHJ1bm5pbmcgLT4gUzMgLT4gY2xvbmUgb3IgeW91IGdv
IHJ1bm5pbmcgLT4gcGF1c2VkIC0+IApjbG9uZSBpcyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwg
SSdtIG5vdCB0ZXJyaWJseSB3b3JyaWVkIGFib3V0LiBVc2VycyAKY2FuIGRvIGVpdGhlciwgYmVj
YXVzZSBvbiBib3RoIGNhc2VzIHRoZSBWTSBpcyBpbiBwYXVzZWQgc3RhdGUuCgoKPiB0aGlzIGlz
bid0IHJlbGF0ZWQgdG8gdGhlIFZNIGZvcmsgaXNzdWUuIEkgdXNlIHRob3NlIFBNIG5vdGlmaWVy
cwo+IGhhcHBpbHkgaW4ga2VybmVsIHNwYWNlIGJ1dCBBRkFJQ1QsIHRoZXJlJ3Mgc3RpbGwgbm8g
dXNlcnNwYWNlIHRoaW5nIGZvcgo+IGl0LiBUaGlzIHNlZW1zIG9ydGhvZ29uYWwgdG8gdGhpcyBj
b252ZXJzYXRpb24gdGhvdWdoLCBzbyBsZXQncyBub3QgdmVlcgo+IG9mZiBpbnRvIHRoYXQgdG9w
aWMuCj4KPiBJZiB5b3UgZGlkbid0IG1lYW4gUzMgYnV0IGFjdHVhbGx5IG1lYW50IG5vdGlmaWNh
dGlvbiBwcmlvciB0byBzbmFwc2hvdAo+IHRha2luZywgd2UgZG9uJ3QgaGF2ZSBhbnkgdmlydHVh
bCBoYXJkd2FyZSBmb3IgdGhhdCwgc28gaXQncyBhIG1vb3QKPiBwb2ludC4KCgpJIHRoaW5rIHdl
J2xsIHdhbnQgdG8gaGF2ZSBhbiBleHRlcm5hbCBidXR0b24gc2ltaWxhciB0byB0aGUgQUNQSSBz
bGVlcCAKYnV0dG9uIG9yIGxpZCBjbG9zZSBldmVudCBldmVudHVhbGx5LCBzbyB0aGF0IHdlIGNh
biBsb29wIHRoZSBWTSBpbiBvbiAKdGhlIHN1c3BlbmQgcGF0aCB0aGUgc2FtZSB3YXkgUzMgZG9l
cy4KClRvZGF5IHdlIGRvbid0IGhhdmUgaXQsIEkgYWdyZWUuIEFuZCBpZiBpdCdzIHBvc3NpYmxl
IHRvIG1haW50YWluIHRoZSAKc2FtZSB1c2VyIHNwYWNlIGludGVyZmFjZSB3aXRoIHRoaXMgaW4g
bWluZCwgYWxsIGlzIGdvb2QuIExldCdzIGp1c3QgCmtlZXAgaXQgaW4gbWluZCBhcyBzb21ldGhp
bmcgdGhhdCB3aWxsIHByb2JhYmx5IGNvbWUgZXZlbnR1YWxseSBzbyB0aGF0IAp3ZSBkb24ndCBy
ZWRlc2lnbiB0aGUgVUFQSSBpbiBhIHllYXIgZnJvbSBub3cuCgoKPgo+PiAzKSBOb3RpZmljYXRp
b25zIGFmdGVyIGNsb25lIHNvIGFwcGxpY2F0aW9ucyBrbm93IHRoZXkgY2FuIHJlZ2VuZXJhdGUg
Vk0KPj4gdW5pcXVlIGRhdGEgYmFzZWQgb24gcmFuZG9tbmVzcy4KPiBZb3UgbWVhbiB0aGlzIGFz
ICJ0aGUgc2FtZSBhcyAoMSkgYnV0IHdpdGggcG9sbCgpIGluc3RlYWQgb2YgbW1hcCgpIiwKPiBy
aWdodD8KCgpZZXMgOikKCgo+Cj4+IExlbm5hcnQsIGxvb2tpbmcgYXQgdGhlIGN1cnJlbnQgc3lz
Y3RsIHByb3Bvc2FsLCBzeXN0ZW1kIGNvdWxkIHBvbGwoKSBvbgo+PiB0aGUgZm9yayBmaWxlLiBJ
dCB3b3VsZCB0aGVuIGJlIGFibGUgdG8gZ2VuZXJhdGUgYSAvcnVuL2ZvcmstaWQgZmlsZQo+PiB3
aGljaCBpdCBjYW4gdXNlIGZvciB0aGUgZmxvdyBhYm92ZSwgcmlnaHQ/Cj4gRm9yIHRoZSByZWFz
b25zIEkgZ2F2ZSBpbiBteSBsYXN0IGVtYWlsIHRvIExlbm5hcnQsIEkgZG9uJ3QgdGhpbmsKPiB0
aGVyZSdzIGEgZ29vZCB3YXkgZm9yIHN5c3RlbWQgdG8gZ2VuZXJhdGUgYSBmb3JrLWlkIGZpbGUg
b24gaXRzIG93bgo+IGVpdGhlci4gSSBkb24ndCB0aGluayBzeXN0ZW1kIHNob3VsZCByZWFsbHkg
YmUgaW52b2x2ZWQgaGVyZSBhcyBhCj4gcHJvdmlkZXIgb2YgdmFsdWVzLCBqdXN0IGFzIGEgcG90
ZW50aWFsIGNvbnN1bWVyIG9mIHdoYXQgdGhlIGtlcm5lbAo+IHByb3ZpZGVzLgoKClllcywgc3lz
dGVtZCB3b3VsZCBwb2xsIG9uIGZvcmtfZXZlbnQuIFdoZW4gdGhhdCByZXR1cm5zLCBpdCByZWFk
cyAKL2Rldi91cmFuZG9tIGFuZCB3cml0ZXMgYSBuZXcgL3J1bi9mb3JrLWlkIGZpbGUgd2l0aCB0
aGF0LiBMaWJyYXJpZXMgCnRoYXQgZG9uJ3Qgd2FudCB0byBiZSBpbiB0aGUgYnVzaW5lc3Mgb2Yg
c3Bhd25pbmcgdGhyZWFkcyBjYW4gdXNlIHRoYXQgCmZpbGUgdG8gaWRlbnRpZnkgdGhhdCB0aGV5
IHdlcmUgY2xvbmVkLiBTeXN0ZW1kIGNhbiB1c2UgdGhhdCBpZCBhcyBzZWVkIApmb3IgbmV0d29y
a2QuCgoKPgo+PiBUaGUgc3lzY3RsIHByb3Bvc2FsIGFsc28gZ2l2ZXMgdXMgMywgaWYgd2UgaW1w
bGVtZW50IHRoZSBpbmhpYml0b3IKPj4gcHJvcG9zYWwgWzFdIGluIHN5c3RlbWQuCj4gVGhlc2Ug
dXNlcnNwYWNlIGNvbXBvbmVudHMgeW91J3JlIHByb3Bvc2luZyBzZWVtIGxpa2UgYSBsb3Qgb2YK
PiBvdmVyZW5naW5lZXJpbmcgZm9yIGxpdHRsZSBnYWluLCB3aGljaCBpcyB3aHkgdGhpcyBjb252
ZXJzYXRpb24gd2VudAo+IG5vd2hlcmUgd2hlbiBBbWF6b24gYXR0ZW1wdGVkIGFsbCB0aGlzIHll
YXIuIEJ1dCBpdCBzb3VuZHMgbGlrZSB5b3UKPiBhZ3JlZSB3aXRoIG1lIGJhc2VkIG9uIHlvdXIg
cmVtYXJrIGJlbG93IGFib3V0IHN5c3RlbWQtbGVzcyBpbnRlcmZhY2VzCj4gcHJvdmlkZWQgYnkg
dGhlIGtlcm5lbC4KCgpJIHdvdWxkIGJlIGhhcHB5IHRvIGdldCB0byA5OSUgb2YgdGhpcyB3aXRo
IHB1cmUga2VybmVsIGJhc2VkIAppbnRlcmZhY2VzLiBUaGUgcmVhc29uIHRoZSBrZXJuZWwgY29u
dmVyc2F0aW9uIHNlZW1pbmdseSB3ZW50IG5vd2hlcmUgCndhcyBub3QgYmVjYXVzZSBvZiAib3Zl
cmVuZ2luZWVyaW5nIi4gSXQgd2FzIGJlY2F1c2UgdGhlIHJldmlldyBmZWVkYmFjayAKZXZlbnR1
YWxseSB3YXMgIlRoaXMgaXMgYSBmaWxlLCBtYWtlIHVzZXIgc3BhY2UgbWFuYWdlIGl0Ii4KCgo+
PiBPdmVyYWxsLCBpdCBzb3VuZHMgdG8gbWUgbGlrZSB0aGUgc3lzY3RsIHBvbGwgYmFzZWQga2Vy
bmVsIGludGVyZmFjZSBpbgo+PiB0aGlzIHBhdGNoIGluIGNvbWJpbmF0aW9uIHdpdGggc3lzdGVt
ZCBpbmhpYml0b3JzIGdpdmVzIHVzIGFuIGFuc3dlciB0bwo+PiBtb3N0IG9mIHRoZSBmbG93cyBh
Ym92ZS4KPj4KPj4gSSBjYW4gc2VlIGF0dHJhY3RpdmVuZXNzIGluIHByb3ZpZGluZyB0aGUgL3J1
bi9mb3JrLWlkIGRpcmVjdGx5IGZyb20gdGhlCj4+IGtlcm5lbCB0aG91Z2gsIHRvIHJlbW92ZSB0
aGUgZGVwZW5kZW5jeSBvbiBzeXN0ZW1kIGZvciBwb2xsLWxlc3MKPj4gbm90aWZpY2F0aW9uIG9m
IGxpYnJhcmllcy4KPj4KPj4gSmFzb24sIGhvdyBtdWNoIGNvbXBsZXhpdHkgd291bGQgaXQgYWRk
IHRvIHByb3ZpZGUgYW4gbW1hcCgpIGFuZCByZWFkKCkKPj4gaW50ZXJmYWNlIHRvIGEgZm9yayBj
b3VudGVyIHZhbHVlIHRvIHRoZSBzeXNjdGw/IFJlYWQgc291bmRzIGxpa2UgYQo+PiB0cml2aWFs
IGNoYW5nZSBvbiB0b3Agb2Ygd2hhdCB5b3UgaGF2ZSBhbHJlYWR5LCBtbWFwIGEgYml0IG1vcmUg
aGVhdnkKPj4gbGlmdC4gSWYgd2UgaGFkIGJvdGgsIGl0IHdvdWxkIGFsbG93IHVzIHRvIGltcGxl
bWVudCBhIExpbnV4IHN0YW5kYXJkCj4+IGZvcmsgZGV0ZWN0IHBhdGggaW4gbGlicmFyaWVzIHRo
YXQgZG9lcyBub3QgcmVseSBvbiBzeXN0ZW1kLgo+IG1tYXAoKSBkb2VzIG5vdCBnaXZlIHVzIGFu
eXRoaW5nIGlmIHdlJ3JlIG5vdCBnb2luZyB0byBleHBvc2UgdGhlIHJhdwo+IEFDUEktbWFwcGVk
IElEIGRpcmVjdGx5LiBJdCB3aWxsIHN0aWxsIGJlIGEgcmFjeSBtZWNoYW5pc20gdW50aWwgd2Ug
ZG8KPiB0aGF0LiBTbyBJIHRoaW5rIHdlIHNob3VsZCB3YWl0IHVudGlsIHRoZXJlJ3MgYSBwcm9w
ZXIgdm1nZW5pZAo+IHdvcmQtc2l6ZWQgY291bnRlciB0byBleHBvc2Ugc29tZXRoaW5nIG1tYXAo
KWFibGUuIElmIHlvdSBoYXZlIHRoZQo+IGVuZXJneSB0byB0YWxrIHRvIE1pY3Jvc29mdCBhYm91
dCB0aGlzIGFuZCBtYWtlIGl0IGhhcHBlbiwgcGxlYXNlIGJlIG15Cj4gZ3Vlc3QuIEFzIEkgd3Jv
dGUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGlzIGVtYWlsLiBJIGhhdmVuJ3QgZ290dGVuIGEKPiBy
ZXNwb25zZSBmcm9tIHlvdSBhdCBhbGwgYWJvdXQgdGhpcyBzdHVmZiBpbiBxdWl0ZSBzb21lIHRp
bWUsIHNvIEknbSBub3QKPiByZWFsbHkgaXRjaGluZyB0YWtlIHRoYXQgb24gYWxvbmUgbm93LgoK
CkFic29sdXRlbHkhIExldCdzIHNlZSB3aGVyZSBpdCBnb2VzIDopCgoKQWxleAoKCgoKCkFtYXpv
biBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJl
cmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdl
aXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAx
NDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

