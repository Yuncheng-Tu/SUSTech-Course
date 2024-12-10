## Course final project

We explored several classic architectures, beginning with an OTA as the first stage to boost differential gain and a common-source structure as the second stage to provide a large output swing. We then investigated a self-biased folded cascode stage cascaded with a CS stage. These attempts allowed me to delve deeper into the trade-offs in circuit design, such as balancing gain error with speed (small-signal bandwidth) or managing the relationship between open-loop gain and VDD. In exploring various designs, curiosity drove us to try a fully differential folded cascode-source follower-OTA design to achieve optimal amplification performance while keeping the common-mode gain low. However, the three-stage amplifier presented significant stability challenges, requiring compensation for its phase margin. After multiple trials, we refined the design to a two-stage architecture employing a differential-input, single-ended-output self-biased folded cascode stage cascaded with a common-source stage, effectively resolving stability issues while meeting all performance metrics.