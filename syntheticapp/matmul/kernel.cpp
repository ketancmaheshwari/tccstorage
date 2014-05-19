
////////////////////////////////////////////////////////////////////////////////
//! Compute reference data set
//! C = A * B
//! @param C          reference data, computed but preallocated
//! @param A          matrix A as provided to device
//! @param B          matrix B as provided to device
//! @param hA         height of matrix A
//! @param wB         width of matrix B
////////////////////////////////////////////////////////////////////////////////
#include <memory.h>

void
computeGold(float* C, const float* A, const float* B, unsigned int hA, unsigned int wA, unsigned int wB)
{
    const int block_hA = 8;
    const int block_wB = 8;
    const int block_wA = 4;
    int hA_segs = hA/block_hA;
    int wB_segs = wB/block_wB;
    int wA_segs = wA/block_wA;
    #pragma omp parallel for default(none) shared(A, B, C, hA, wA, wB)
    for (unsigned int i_seg = 0; i_seg < hA; i_seg+=block_hA) {
      for (unsigned int j_seg = 0; j_seg < wB; j_seg+=block_wB) {
        float partials[block_hA][block_wB];
        memset(partials, 0, sizeof(float)*block_hA*block_wB);
        for (unsigned int k_seg = 0; k_seg < wA; k_seg += block_wA) {
          for(int ii = 0; ii<block_hA; ii++) {
            int i = i_seg+ii;
            for(int jj=0; jj<block_wB; jj++) {
              int j = j_seg+jj;
              for (unsigned int kk = 0; kk < block_wA; ++kk) {
                  int k = k_seg + kk;
                  double a = A[i * wA + k];
                  double b = B[k * wB + j];
                  partials[ii][jj] += a * b;
              }
            }
          }
        }
        for(int ii = 0; ii<block_hA; ii++)
          for(int jj=0; jj<block_wB; jj++)
            C[(i_seg+ii) * wB + (j_seg+jj)] = (float)partials[ii][jj];
      }
    }
}

