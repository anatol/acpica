    /*
     * Some or all of this work - Copyright (c) 2006 - 2018, Intel Corp.
     * All rights reserved.
     *
     * Redistribution and use in source and binary forms, with or without modification,
     * are permitted provided that the following conditions are met:
     *
     * Redistributions of source code must retain the above copyright notice,
     * this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright notice,
     * this list of conditions and the following disclaimer in the documentation
     * and/or other materials provided with the distribution.
     * Neither the name of Intel Corporation nor the names of its contributors
     * may be used to endorse or promote products derived from this software
     * without specific prior written permission.
     *
     * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
     * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
     * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
     * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
     * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
     * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
     * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     */
    /*
     * Bug 262:
     *
     * SUMMARY: Unexpected AE_STACK_OVERFLOW for a method call expression with nested calls
     */
    Method (M027, 0, Serialized)
    {
        Name (IAD1, 0x01)
        Name (IAD2, 0x10)
        Name (IAD3, 0x0100)
        Name (IAD4, 0x1000)
        Name (IAD5, 0x00010000)
        Name (IAD6, 0x00100000)
        Name (IAD7, 0x01000000)
        Method (MAD1, 1, NotSerialized)
        {
            Return (Arg0)
        }

        Method (MAD7, 7, NotSerialized)
        {
            Return (((((((Arg0 + Arg1) + Arg2) +
                Arg3) + Arg4) + Arg5) + Arg6))
        }

        Method (M000, 0, NotSerialized)
        {
            Local0 = MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD7 (MAD1 (IAD1), MAD1 (IAD2), MAD1 (IAD3), MAD1 (IAD4), MAD1 (
                IAD5), MAD1 (IAD6), MAD1 (IAD7))))))))
            Debug = Local0
            If ((Local0 != 0x01777777))
            {
                ERR (__METHOD__, ZFFF, __LINE__, 0x00, 0x00, Local0, 0x01777777)
            }
        }

        CH03 ("", 0x00, 0x01, 0x42, 0x00)
        M000 ()
        CH03 ("", 0x00, 0x02, 0x44, 0x00)
    }
